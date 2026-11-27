as yet unclassified
courses
	| items |
	self client path: ('/services/journal/gradebook/{1}/entries' format: {self id}).
	items := self client
			withStreaming: [ | znStream |
				znStream := ZnCharacterReadStream on: self client get.
				(NeoJSONReader on: znStream)
					for: #Courses
						customDo: (connection injectMapping: StudentGrade);
					for: StudentGrade
						do: [ :m | 
							m mapInstVars.
							(m mapInstVar: 'scheduleSubjects') valueSchema: #Subjects ];
					for: #Subjects
						customDo: (connection injectMapping: StudySubject);
					for: StudySubject do: #mapInstVars;
					nextAs: #Courses ].
	items do: [:c | c scheduleSubjects do: [:s | s subjectGrade: c ]].
	^items