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

{ #category : #'as yet unclassified' }
StudySubject >> absentEntityOf: anAsuAbsenceReason [ 
^ Dictionary new
	at: #absenceReason put: nil;
	at: #absenceType put: anAsuAbsenceReason reason;
	at: #marks put: Dictionary new;
	yourself.
	
]

{ #category : #'as yet unclassified' }
StudySubject >> addTask: aSubjectTask forLesson: aSubjectLesson forUsers: anArrayOfSubjectUser [
	| format path |
	format := {self subjectGrade id.
			self id.
			aSubjectLesson id. }.
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}/tasks' format: format.
	self client path: path.
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

{ #category : #'as yet unclassified' }
StudySubject >> printOn: aStream [
aStream << name
]

{ #category : #'as yet unclassified' }
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
