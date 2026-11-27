accessing
journal: source
	| items atts attendantSource newAts element |
	newAts := self buildAttendances: source.
	attendantSource := (self loadSource: self attendanceSource)
			collect: [ :each | ObsidianAttendance new data: each ].
	atts := newAts & attendantSource | newAts.
	items := (atts sort: self sortByNameThenActivity) collect: [:x | x asElement].

	element := BlElement new
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ];
			addChild: (BlElement new
						layout: (BlGridLayout new columnCount: 1);
						padding: (BlInsets left: 4 right: 4);
						constraintsDo: [:c |
						c horizontal fitContent.
						c vertical matchParent
						];
						addChildren: ({self group base}, (self group files collect: #base) sort
								collect: [ :each | 
									BlElement new
									"	border: (BlBorder paint: Color black width: 1);"
										layout: BlFrameLayout new;
										constraintsDo: [ :c | 
											c horizontal fitContent.
											c vertical matchParent ];
										addChild: (BlTextElement new
												text: each asRopedText;
												constraintsDo: [ :c | 
													c frame vertical alignCenter.
													c frame horizontal alignCenter ]) ]));
			addChild: (BlElement new
					layout: (BlGridLayout new columnCount: source files size);
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical matchParent ];
					addChildren: ((1 to: source files size)
							collect: [ :index | 
								BlElement new
									border: (BlBorder paint: Color black width: 1);
									layout: BlFrameLayout new;
									constraintsDo: [ :c | 
										c horizontal matchParent.
										c vertical matchParent ];
									addChild: (BlTextElement new
											text: index asString asRopedText;
											constraintsDo: [ :c | 
												c frame vertical alignCenter.
												c frame horizontal alignCenter ]) ]);
			addChildren: items).
	^ ObsidianJournal new
		source: self attendanceSource;
		sourced: attendantSource;
		replica: self;
		element: element;
		items: atts