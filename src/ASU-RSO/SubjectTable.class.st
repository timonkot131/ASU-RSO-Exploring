Class {
	#name : #SubjectTable,
	#superclass : #Object,
	#instVars : [
		'lessons',
		'students',
		'studySubject',
		'connection'
	],
	#category : #'ASU-RSO-Model'
}

{ #category : #'as yet unclassified' }
SubjectTable >> client [ 
^ connection client
]

{ #category : #accessing }
SubjectTable >> connection [
	^ connection
]

{ #category : #accessing }
SubjectTable >> connection: anObject [
	connection := anObject
]

{ #category : #views }
SubjectTable >> gtLessonsFor: aView [
	<gtView>
	^ aView forward
		title: 'Пары';
		object: [ lessons ];
		view: #gtItemsFor:
]

{ #category : #views }
SubjectTable >> gtStudentsFor: aView [
	<gtView>
	^ aView forward
		title: 'Студенты';
		object: [ students ];
		view: #gtItemsFor:
]

{ #category : #accessing }
SubjectTable >> lessons [
	^ lessons
]

{ #category : #accessing }
SubjectTable >> lessons: anObject [
	lessons := anObject
]

{ #category : #accessing }
SubjectTable >> students [
	^ students
]

{ #category : #accessing }
SubjectTable >> students: anObject [
	students := anObject
]

{ #category : #accessing }
SubjectTable >> studySubject [
	^ studySubject
]

{ #category : #accessing }
SubjectTable >> studySubject: anObject [
	studySubject := anObject
]
