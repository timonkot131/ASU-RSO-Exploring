API
totals
	| format path contents res rows |
	format := {self subjectGrade id.
			self id}.
	path := 'services/journal/examination/{1}/subjects/{2}' format: format.
	self client
		path: path;
		get.
	contents := self client response contents.
	res := STONJSON fromString: contents.
	rows := (res at: #students)
			collect: [ :each | 
				TotalSubjectRow new
					firstName: (each at: #firstName);
					lastName: (each at: #lastName);
					middleName: (each at: #middleName ifAbsentPut: ['']);
					id: (each at: #id) ].
	^rows
		do: [ :each | 
			| marks |
			each average: (((res at: #subgroups) last at: #marks) in:[ :aDict | aDict at: each id asString ifAbsent: [0]]).
			marks := res at: #marks.
			each
				final: (marks
						at: each id asString
						ifPresent: [ :anItem | anItem at: #value ifPresent: [:aMark |
							GradeExecution wordToNum: aMark] ifAbsent: ['.'] ]
						ifAbsent: [ '.' ]) ]