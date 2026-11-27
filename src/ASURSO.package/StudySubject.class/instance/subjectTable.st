as yet unclassified
subjectTable
	| result |
	self client
		path: ('/services/journal/gradebook/{1}/subjects/{2}'
				format: {self subjectGrade id.
						self id}).
	result := self client
			withStreaming: [ | znStream |
				znStream := ZnCharacterReadStream on: self client get.
				(NeoJSONReader on: znStream)
					for: SubjectLesson
						do: [ :lesson | 
							lesson mapInstVars.
							(lesson mapInstVar: #tasks) valueSchema: #Tasks ];
					mapAllInstVarsFor: ProgrammLesson;
					mapAllInstVarsFor: SubjectStudent;
					for: SubjectTable
						do: [ :table | 
							table mapInstVars.
							(table mapInstVar: 'workingProgram') valueSchema: WorkingProgramm.
							(table mapInstVar: 'lessons') valueSchema: #Lessons.
							(table mapInstVar: 'students') valueSchema: #Students ];
					for: WorkingProgramm
						do: [ :programm | 
							programm mapInstVars.
							(programm mapInstVar: 'topics') valueSchema: #Topics ];
					for: ProgrammTopic
						do: [ :topic | 
							topic mapInstVars.
							(topic mapInstVar: 'lessons') valueSchema: #ProgrammLessons ];
					for: SubjectTask
						do: [ :task | 
							task mapInstVar: #attachments.
							task mapInstVar: #id.
							task mapInstVar: #type.
							task mapInstVar: #name to: #topic ];
					for: #Tasks
						customDo: [ :mapping | mapping listOfElementSchema: SubjectTask ];
					for: #Topics
						customDo: [ :mapping | mapping listOfElementSchema: ProgrammTopic ];
					for: #ProgrammLessons
						customDo: (self connection injectMapping: ProgrammLesson);
					for: #Lessons
						customDo: [ :mapping | mapping listOfElementSchema: SubjectLesson ];
					for: #Students
						customDo: [ :mapping | mapping listOfElementSchema: SubjectStudent ];
					nextAs: SubjectTable ].


	result workingProgramm
		ifNil: [ result lessons: { } ]
		ifNotNil: [ | lessons |
			lessons := result workingProgramm topics flatCollect: #lessons.
			result lessons
				do: [ :lesson | 
					lesson
						studySubject: self;
						name: (lessons
								detect: [ :each | lesson plannedLessons includesKey: each id asString ]
								ifFound: #name
								ifNone: [ 'Не выставлено' ]);
						subjectTable: result ].
			result workingProgramm connection: self connection ].
	result studySubject: self.
	^ result connection: self connection