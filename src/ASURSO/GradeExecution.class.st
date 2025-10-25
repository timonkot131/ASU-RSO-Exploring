Class {
	#name : #GradeExecution,
	#superclass : #Object,
	#instVars : [
		'subject',
		'lesson',
		'student',
		'importer',
		'grade',
		'task',
		'required'
	],
	#category : #'ASURSO-Model'
}

{ #category : #utility }
GradeExecution class >> numToWord: anInteger [
	^{
		1 -> 'One'.
		2 -> 'Two'.
		3 -> 'Three'.
		4 -> 'Four'.
		5 -> 'Five'.
	} asDictionary at: anInteger

]

{ #category : #'as yet unclassified' }
GradeExecution >> = anObject [
(self isKindOf: anObject) ifTrue: [ 
	^self student = anObject student
].
^false.
]

{ #category : #accessing }
GradeExecution >> grade [
	^ grade
]

{ #category : #accessing }
GradeExecution >> grade: anObject [
	grade := anObject
]

{ #category : #comparing }
GradeExecution >> hash [
	^ self student hash hashMultiply
]

{ #category : #accessing }
GradeExecution >> importer [
	^ importer
]

{ #category : #accessing }
GradeExecution >> importer: anObject [
	importer := anObject
]

{ #category : #initialization }
GradeExecution >> initialize [
self required: true
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
GradeExecution >> required [
	^ required
]

{ #category : #accessing }
GradeExecution >> required: anObject [
	required := anObject
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

{ #category : #accessing }
GradeExecution >> task [
	^ task
]

{ #category : #accessing }
GradeExecution >> task: anObject [
	task := anObject
]
