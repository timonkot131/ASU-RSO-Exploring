Class {
	#name : #StudySubject,
	#superclass : #Object,
	#instVars : [
		'connection',
		'plannedHours',
		'id',
		'name',
		'remarks',
		'isAttendanceEditable',
		'subjectGrade'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
StudySubject >> = anObject [
^(anObject isKindOf: StudySubject) ifTrue:
 [self name = anObject name]
]

{ #category : #utilities }
StudySubject >> absentEntityOf: anAsuAbsenceReason [ 
^ Dictionary new
	at: #absenceReason put: nil;
	at: #absenceType put: anAsuAbsenceReason reason;
	at: #marks put: Dictionary new;
	yourself.
	
]

{ #category : #API }
StudySubject >> addTask: aSubjectTask forLesson: aSubjectLesson forUsers: anArrayOfSubjectUser [
	| format path requiredMarks |
	format := {self subjectGrade id.
			self id.
			aSubjectLesson id}.
	requiredMarks := Dictionary new
			in: [ :dict | 
				anArrayOfSubjectUser
					do: [ :each | 
						dict
							at: each id asString
							put: {'isRequired' -> true.
									'value' -> nil} asDictionary ].
				STONJSON toString: dict ].
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}/tasks'
			format: format.
	
	self client
		resetEntity;
		path: path.
		(self client multiPartFormDataEntity
				addPart: (ZnMimePart fieldName: 'type' value: aSubjectTask type);
				addPart: (ZnMimePart fieldName: 'topic' value: aSubjectTask name);
				addPart: (ZnMimePart fieldName: 'marks' value: requiredMarks);
				addPart: (ZnMimePart
						fieldName: 'file'
						fileName: aSubjectTask file basename
						entity: (ZnEntity bytes: aSubjectTask file binaryContents))).
		
	self client post.
]

{ #category : #API }
StudySubject >> bindLesson: aSubjectLesson to: aProgrammLesson [
	| preparedEntity format path|
	preparedEntity := ZnEntity
			json: (STONJSON toString: (self prepareBind: aSubjectLesson to: aProgrammLesson)).
	format := {self subjectGrade id.
			self id}.
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons' format: format.
	self client path: path; entity: preparedEntity; post.
	^self client response.
]

{ #category : #'as yet unclassified' }
StudySubject >> client [ 
^ connection client
]

{ #category : #accessing }
StudySubject >> connection [
	^ connection
]

{ #category : #accessing }
StudySubject >> connection: anObject [
	connection := anObject
]

{ #category : #API }
StudySubject >> deleteLesson: aSubjectLesson [
	| format path|
	format := {self subjectGrade id.
			self id.
			aSubjectLesson id.}.
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}' format: format.
	self client path: path; delete.
	^self client response.
]

{ #category : #views }
StudySubject >> gtPairsFor: aView [
	<gtView>
	^ aView forward
		title: 'Пары';
		priority: 10;
		object: [ self subjectTable ];
		actionUpdateButton;
		view: #gtLessonsFor: 
]

{ #category : #'as yet unclassified' }
StudySubject >> gtSubjectTable: anAction [
<gtAction>
	^ anAction button
		priority: 76;
		icon: BrGlamorousVectorIcons note;
		tooltip: 'Открыть журнал предмета';
		id: GtInspectorInspectButtonId;
		action: [ :aButton |
			aButton phlow spawnObject: self subjectTable ];
		primaryModifierAction: [ :aButton |
				aButton phlow showObject: self subjectTable ]
			mouseCursor: BlCopyCursor new

]

{ #category : #views }
StudySubject >> gtView2For: aView [
	<gtView>
	^ aView forward
		title: 'Наполнение';
		object: [ self subjectTable ];
		view: #gtWorkingProgramFor:
]

{ #category : #views }
StudySubject >> gtViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Студенты';
		priority: 20;
		object: [ self subjectTable ];
		view: #gtStudentsFor:
]

{ #category : #comparing }
StudySubject >> hash [
	^ self name hash hashMultiply
]

{ #category : #accessing }
StudySubject >> id [
	^ id
]

{ #category : #accessing }
StudySubject >> id: anObject [
	id := anObject
]

{ #category : #accessing }
StudySubject >> name [
	^ name
]

{ #category : #accessing }
StudySubject >> name: anObject [
	name := anObject
]

{ #category : #utilities }
StudySubject >> prepareBind: aSubjectLesson to: aProgrammLesson [ 
^Dictionary new 
		at: #date put: aSubjectLesson date;
		at: #duration put: aProgrammLesson duration;
		at: #type put: aProgrammLesson type;
		at: #scheduleLessonId put: aSubjectLesson scheduleLessonId;
		at: #plannedLessons put: (Dictionary new at: aProgrammLesson id asString 
			put: aProgrammLesson duration; yourself);
		yourself.
		
]

{ #category : #'as yet unclassified' }
StudySubject >> printOn: aStream [
aStream << name
]

{ #category : #API }
StudySubject >> removeTaskForLesson: aSubjectLesson [
	^aSubjectLesson tasks
		collect: [ :each | 
			| format path |
			format := {self subjectGrade id.
					self id.
					aSubjectLesson id.
					each id}.
			path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}/tasks/{4}'
					format: format.
			self client
				path: path;
				delete. ]
]

{ #category : #API }
StudySubject >> setAbsenceLesson: aSubjectLesson student: aSubjectUser type: anAsuAbsenceReason [
	| format path |
	format := {self subjectGrade id.
			self id.
			aSubjectLesson id.
			aSubjectUser id}.
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}/students/{4}'
			format: format.
	self client path: path ;
		entity: (ZnEntity json: (STONJSON toString: (self absentEntityOf: anAsuAbsenceReason )));
		put.
	^self client response
]

{ #category : #accessing }
StudySubject >> subjectGrade [
	^ subjectGrade
]

{ #category : #accessing }
StudySubject >> subjectGrade: anObject [
	subjectGrade := anObject
]

{ #category : #'as yet unclassified' }
StudySubject >> subjectGroup [ 
	^ subjectGrade studentGroup
]

{ #category : #'as yet unclassified' }
StudySubject >> subjectTable [
	| result lessons |
	self client path: ('/services/journal/gradebook/{1}/subjects/{2}' format: {self subjectGrade id. self id}).
	result := self client withStreaming: [ | znStream |
			znStream := ZnCharacterReadStream on: self client get.
			(NeoJSONReader on: znStream)
				for: SubjectLesson do: [:lesson | 
					lesson mapInstVars.
					(lesson mapInstVar: #tasks) valueSchema: #Tasks
				];
				mapAllInstVarsFor: ProgrammLesson;
				mapAllInstVarsFor: SubjectStudent;
				for: SubjectTable do: [:table | 
						table mapInstVars.
						(table mapInstVar: 'workingProgram') valueSchema: WorkingProgramm.
						(table mapInstVar: 'lessons') valueSchema: #Lessons.
						(table mapInstVar: 'students') valueSchema: #Students
					];
				for: WorkingProgramm do: [ :programm |
					programm mapInstVars.
					(programm mapInstVar: 'topics') valueSchema: #Topics. 
				];
				for: ProgrammTopic do: [ :topic |  
					topic mapInstVars.
					(topic mapInstVar: 'lessons') valueSchema: #ProgrammLessons.
					];
				for: SubjectTask do: [:task | 
					task mapInstVar: #id.
					task mapInstVar: #type.
					task mapInstVar: #name to: #topic 
					];
				for: #Tasks customDo: [ :mapping | 
					mapping listOfElementSchema: SubjectTask.
				 ];
				for: #Topics customDo: [ :mapping |
					mapping listOfElementSchema: ProgrammTopic.
				];
				for: #ProgrammLessons customDo: (self connection injectMapping: ProgrammLesson );
				for: #Lessons customDo: [ :mapping | 
					mapping listOfElementSchema: SubjectLesson
					];
				for: #Students customDo: [ :mapping | 
					mapping listOfElementSchema: SubjectStudent
				]; 
				nextAs: SubjectTable].
	
	lessons := result workingProgramm topics flatCollect: #lessons.
	result lessons do: [:lesson | 
		lesson
			studySubject: self;
			name: (lessons detect: [:each | lesson plannedLessons includesKey: each id asString ] ifFound: #name ifNone: ['Не выставлено']); subjectTable: result. ]. 
	result workingProgramm connection: self connection.
	result studySubject: self. 
	^result connection: self connection.
]
