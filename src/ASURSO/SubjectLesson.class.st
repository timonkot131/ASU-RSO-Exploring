Class {
	#name : #SubjectLesson,
	#superclass : #Object,
	#instVars : [
		'id',
		'date',
		'scheduleLessonId',
		'type',
		'tasks',
		'markSets',
		'duration',
		'startTime',
		'endTime',
		'name',
		'plannedLessons',
		'studySubject',
		'workingProgramm',
		'subjectTable'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
SubjectLesson >> = anObject [
^((anObject isKindOf: ProgrammLesson) or: [ anObject isKindOf: SubjectLesson]) ifTrue: [ self name = anObject name ]
]

{ #category : #accessing }
SubjectLesson >> absent [
	^(self markSets associations select: [:kv | kv value includesKey: #absenceType]
		thenCollect: [ :kv | 
			(self students detect: [ :student | student id = kv key asInteger ])
				-> (kv value at: 'absenceType') ]) asDictionary
]

{ #category : #'as yet unclassified' }
SubjectLesson >> children [ ^self markSets  "ifNil: [(Dictionary new at: 'noway' put: 'ok'; yourself) associations]"
ifNil: [{}]
]

{ #category : #accessing }
SubjectLesson >> date [
	^ date
]

{ #category : #accessing }
SubjectLesson >> date: anObject [
	date := anObject
]

{ #category : #accessing }
SubjectLesson >> dateString [
	^ self date asDate yyyymmdd
]

{ #category : #accessing }
SubjectLesson >> duration [
	^ duration
]

{ #category : #accessing }
SubjectLesson >> duration: anObject [
	duration := anObject
]

{ #category : #accessing }
SubjectLesson >> endTime [
	^ endTime
]

{ #category : #accessing }
SubjectLesson >> endTime: anObject [
	endTime := anObject
]

{ #category : #views }
SubjectLesson >> gtMarks: aView [
	<gtView>
	^ aView columnedList
		title: 'Оценки';
		items: [ self marks ];
		column: 'Имя' text: #student;
		column: 'Оценка' text: [ :each |
		
			{'Five' -> 5.
			 'Four' -> 4.
			 'Three' -> 3.
			 'Two' -> 2.
			 nil -> 'Не выставлено'	 
			} asDictionary at: each grade
		
		].
]

{ #category : #views }
SubjectLesson >> gtView1For: aView [
	<gtView>
	^ aView forward
		title: 'Нки';
		object: [ self absent select: [ :x | x = AsuAbsenceReason noValidReason reason ] ];
		view: #gtKeysFor:
]

{ #category : #views }
SubjectLesson >> gtViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Отсутствующие';
		object: [ self absent ];
		view: #gtItemsFor:
]

{ #category : #comparing }
SubjectLesson >> hash [
	^ self name hash hashMultiply
]

{ #category : #accessing }
SubjectLesson >> id [
	^ id
]

{ #category : #accessing }
SubjectLesson >> id: anObject [
	id := anObject
]

{ #category : #accessing }
SubjectLesson >> markSets [
	^ markSets
]

{ #category : #accessing }
SubjectLesson >> markSets: anObject [
	markSets := anObject
]

{ #category : #'as yet unclassified' }
SubjectLesson >> marks [
	| students thisTasks |
	students := self students groupedBy: #id.
	thisTasks := self tasks groupedBy: #id.
	^ self markSets associations
		select: [ :kv | kv value includesKey: #marks ]
		thenFlatCollect: [ :pair | 
			| marks |
			marks := (pair value at: #marks) associations.
			marks collect: [ :each |
			GradeExecution new 
				student: (students at: pair key asInteger) first ;
				task: (thisTasks at: each key asInteger) first;
				grade: (each value at: #value ifAbsent: [nil])
				] ] 
			
]

{ #category : #'as yet unclassified' }
SubjectLesson >> name [ 
^name
]

{ #category : #accessing }
SubjectLesson >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SubjectLesson >> plannedLessons [
	^ plannedLessons
]

{ #category : #accessing }
SubjectLesson >> plannedLessons: anObject [
	plannedLessons := anObject
]

{ #category : #'as yet unclassified' }
SubjectLesson >> printOn: aStream [ 
aStream << self name.
self date ifNotNil: [ 
aStream << (' ', self dateString)
]
]

{ #category : #accessing }
SubjectLesson >> scheduleLessonId [
	^ scheduleLessonId
]

{ #category : #accessing }
SubjectLesson >> scheduleLessonId: anObject [
	scheduleLessonId := anObject
]

{ #category : #accessing }
SubjectLesson >> startTime [
	^ startTime
]

{ #category : #accessing }
SubjectLesson >> startTime: anObject [
	startTime := anObject
]

{ #category : #accessing }
SubjectLesson >> students [
^ self subjectTable students
]

{ #category : #'as yet unclassified' }
SubjectLesson >> studySubject: aStudySubject [ 
	studySubject := aStudySubject.
]

{ #category : #accessing }
SubjectLesson >> subjectTable [
	^ subjectTable
]

{ #category : #accessing }
SubjectLesson >> subjectTable: anObject [
	subjectTable := anObject
]

{ #category : #accessing }
SubjectLesson >> taskString [
	^ ', ' join: (self tasks collect: #name)
]

{ #category : #accessing }
SubjectLesson >> tasks [
	^ tasks
]

{ #category : #accessing }
SubjectLesson >> tasks: anObject [
	tasks := anObject
]

{ #category : #accessing }
SubjectLesson >> type [
	^ type
]

{ #category : #accessing }
SubjectLesson >> type: anObject [
	type := anObject
]

{ #category : #'as yet unclassified' }
SubjectLesson >> workingProgramm [
^ workingProgramm
]

{ #category : #accessing }
SubjectLesson >> workingProgramm: anObject [
	workingProgramm := anObject
]
