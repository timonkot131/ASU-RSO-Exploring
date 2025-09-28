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
		'subjectTable'
	],
	#category : #'ASU-RSO-Model'
}

{ #category : #accessing }
SubjectLesson >> absent [
	^(self markSets associations select: [:kv | kv value includesKey: #absenceType]
		thenCollect: [ :kv | 
			(self students detect: [ :student | student id = kv key asInteger ])
				-> (kv value at: 'absenceType') ]) asDictionary
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
SubjectLesson >> gtSubjectTableFor: aView [
	<gtView>
	^ aView forward
		title: 'SubjectTable студенты';
		object: [ subjectTable ];
		view: #gtStudentsFor:
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

{ #category : #accessing }
SubjectLesson >> name [
	^ name ifNil: ['Не выставлено']
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
aStream << self name
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

{ #category : #'as yet unclassified' }
SubjectLesson >> students [
	^subjectTable students
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
