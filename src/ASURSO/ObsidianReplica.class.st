Class {
	#name : 'ObsidianReplica',
	#superclass : 'Object',
	#instVars : [
		'attendanceSource',
		'gradeSource',
		'groupSource',
		'practicalSources',
		'lectionSources',
		'lection',
		'practice',
		'group'
	],
	#category : 'ASURSO-Model',
	#package : 'ASURSO',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
ObsidianReplica class >> asObsidianReference: aString [
^ '"[[',aString, ']]"'
]

{ #category : 'as yet unclassified' }
ObsidianReplica class >> fromObsidianReference: aString [
^ aString replaceAllRegex: '[^-\w\s]' with: ''
]

{ #category : 'accessing' }
ObsidianReplica >> attendanceSource [
	^ attendanceSource
]

{ #category : 'accessing' }
ObsidianReplica >> attendanceSource: anObject [
	attendanceSource := anObject
]

{ #category : 'accessing' }
ObsidianReplica >> buildAttendances: source [
	^ self group files
		flatCollect: [ :student | 
			source files
				collect: [ :aLection | 
					ObsidianAttendance new
						data: (Dictionary new
								at: #'Имя' put: (ObsidianReplica asObsidianReference: student base);
								at: #'Занятие' put: (ObsidianReplica asObsidianReference: aLection base);
								at: #'Группа'
									put: (ObsidianReplica asObsidianReference: self group base);
								at: #'Тип отсутствия' put: '';
								yourself) ] ]
]

{ #category : 'magritte' }
ObsidianReplica >> decriptionGroup [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #group;
		label: 'Группа';
		priority: 41;
		options: self groupSource gtChildren ;
		default: self groupSource gtChildren first; "To avoid storing unneeded empty set [1]"
		reference: MAClassDescription new;
		yourself
]

{ #category : 'magritte' }
ObsidianReplica >> decriptionLection [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #lection;
		label: 'Лекции';
		priority: 41;
		options: self lectionSources;
		default: self lectionSources first; "To avoid storing unneeded empty set [1]"
		reference: MAClassDescription new;
		yourself
]

{ #category : 'magritte' }
ObsidianReplica >> decriptionPractice [
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #practice;
		label: 'Практика';
		priority: 40;
		options: self practicalSources;
		default: self practicalSources first; "To avoid storing unneeded empty set [1]"
		reference: MAClassDescription new;
		yourself
]

{ #category : 'exporting' }
ObsidianReplica >> export: aDictionaryArray source: aSource [
aSource deleteAllChildren.
aDictionaryArray do: [ :each | 
	| hash aFile |
	hash := each hash asString.
	aFile := aSource / hash, 'md' .
	aFile writeStreamDo: [:s | 
		s nextPutAll: '---'; cr.
		each keysAndValuesDo: [ :key :value | 
			s nextPutAll: key;
			nextPutAll: ': ';
			nextPutAll: value;
			cr.
		].
		s nextPutAll: '---'.
	]
]
]

{ #category : 'accessing' }
ObsidianReplica >> gradeSource [
	^ gradeSource
]

{ #category : 'accessing' }
ObsidianReplica >> gradeSource: anObject [
	gradeSource := anObject
]

{ #category : 'accessing' }
ObsidianReplica >> group [
	^ group
]

{ #category : 'accessing' }
ObsidianReplica >> group: anObject [
	group := anObject
]

{ #category : 'accessing' }
ObsidianReplica >> groupSource [
	^ groupSource
]

{ #category : 'accessing' }
ObsidianReplica >> groupSource: anObject [
	groupSource := anObject
]

{ #category : 'views' }
ObsidianReplica >> gtLectionFor: aView [
	<gtView>
	^ aView forward
		title: 'Лекции';
		priority: 20;
		object: [ self journal: self lection ];
		view: #gtViewFor:
]

{ #category : 'views' }
ObsidianReplica >> gtPracticeFor: aView [
	<gtView>
	^ aView forward
		title: 'Практика';
		priority: 10;
		object: [ 
			(self journal: self practice)
				collect: [ :c | 
					
				]
			];
		view: #gtViewFor:
]

{ #category : 'accessing' }
ObsidianReplica >> journal: source [
	| items atts attendantSource newAts element |
	newAts := self buildAttendances: source.
	attendantSource := (self loadSource: self attendanceSource)
			collect: [ :each | ObsidianAttendance new data: each ].
	atts := newAts & attendantSource | newAts.
	items := (atts sort: self sortByNameThenActivity) collect: #asElement.

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
]

{ #category : 'accessing' }
ObsidianReplica >> lection [
	^ lection
]

{ #category : 'accessing' }
ObsidianReplica >> lection: anObject [
	lection := anObject
]

{ #category : 'accessing' }
ObsidianReplica >> lectionSources [
	^ lectionSources
]

{ #category : 'accessing' }
ObsidianReplica >> lectionSources: anObject [
	lectionSources := anObject
]

{ #category : 'importing' }
ObsidianReplica >> loadSource: aSource [
^ aSource files collect: [ :each | YAML2JSON fromFile: each ]
]

{ #category : 'accessing' }
ObsidianReplica >> practicalSources [
	^ practicalSources
]

{ #category : 'accessing' }
ObsidianReplica >> practicalSources: anObject [
	practicalSources := anObject
]

{ #category : 'accessing' }
ObsidianReplica >> practice [
	^ practice
]

{ #category : 'accessing' }
ObsidianReplica >> practice: anObject [
	practice := anObject
]

{ #category : 'sorting' }
ObsidianReplica >> sortByNameThenActivity [
^(#name collatedBy: #value), (#activity collatedBy: [:x | (x replaceAllRegex: '[a-zA-Z]' with: '') asInteger])
]
