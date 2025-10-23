Class {
	#name : #GradeExecution,
	#superclass : #Object,
	#instVars : [
		'subject',
		'lesson',
		'student',
		'importer',
		'grade'
	],
	#category : #'ASURSO-Model'
}

{ #category : #accessing }
GradeExecution >> grade [
	^ grade
]

{ #category : #accessing }
GradeExecution >> grade: anObject [
	grade := anObject
]

{ #category : #accessing }
GradeExecution >> importer [
	^ importer
]

{ #category : #accessing }
GradeExecution >> importer: anObject [
	importer := anObject
]

{ #category : #accessing }
GradeExecution >> lesson [
	^ lesson
]

{ #category : #accessing }
GradeExecution >> lesson: anObject [
	lesson := anObject
]

{ #category : #'as yet unclassified' }
GradeExecution >> printOn: aStream [
(student printOn: aStream ).
aStream << (' | ', grade asString)
]

{ #category : #accessing }
GradeExecution >> student [
	^ student
]

{ #category : #accessing }
GradeExecution >> student: anObject [
	student := anObject
]

{ #category : #accessing }
GradeExecution >> subject [
	^ subject
]

{ #category : #accessing }
GradeExecution >> subject: anObject [
	subject := anObject
]
