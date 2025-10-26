Class {
	#name : #ExecutionStatus,
	#superclass : #Object,
	#instVars : [
		'response',
		'group',
		'subject',
		'lesson',
		'client',
		'task',
		'data'
	],
	#category : #'ASURSO-Model'
}

{ #category : #accessing }
ExecutionStatus >> client [ 
	^ client
]

{ #category : #accessing }
ExecutionStatus >> client: anObject [ 
	client := anObject
]

{ #category : #accessing }
ExecutionStatus >> data [
	^ data
]

{ #category : #accessing }
ExecutionStatus >> data: anObject [
	data := anObject
]

{ #category : #accessing }
ExecutionStatus >> group [
	^ group
]

{ #category : #accessing }
ExecutionStatus >> group: anObject [
	group := anObject
]

{ #category : #views }
ExecutionStatus >> gtDataFor: aView [
	<gtView>
	data ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Data';
		items: [ data ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #testing }
ExecutionStatus >> isOk [
^self response isSuccess
]

{ #category : #accessing }
ExecutionStatus >> lesson [
	^ lesson
]

{ #category : #accessing }
ExecutionStatus >> lesson: anObject [
	lesson := anObject
]

{ #category : #accessing }
ExecutionStatus >> response [
	^ response
]

{ #category : #accessing }
ExecutionStatus >> response: anObject [
	response := anObject
]

{ #category : #accessing }
ExecutionStatus >> subject [
	^ subject
]

{ #category : #accessing }
ExecutionStatus >> subject: anObject [
	subject := anObject
]

{ #category : #accessing }
ExecutionStatus >> task [
	^ task
]

{ #category : #accessing }
ExecutionStatus >> task: anObject [
	task := anObject
]
