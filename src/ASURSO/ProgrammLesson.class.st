Class {
	#name : #ProgrammLesson,
	#superclass : #Object,
	#instVars : [
		'id',
		'date',
		'type',
		'markSets',
		'duration',
		'startTime',
		'endTime',
		'name',
		'connection'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
ProgrammLesson >> = anObject [
^((anObject isKindOf: ProgrammLesson) or: [ anObject isKindOf: SubjectLesson]) ifTrue: [ self name = anObject name ]
]

{ #category : #'as yet unclassified' }
ProgrammLesson >> client [
	^self connection client
]

{ #category : #accessing }
ProgrammLesson >> connection [
	^ connection
]

{ #category : #'as yet unclassified' }
ProgrammLesson >> connection: anAsuConnection [ 
	connection := anAsuConnection.
]

{ #category : #accessing }
ProgrammLesson >> date [
	^ date
]

{ #category : #accessing }
ProgrammLesson >> date: anObject [
	date := anObject
]

{ #category : #accessing }
ProgrammLesson >> duration [
	^ duration
]

{ #category : #accessing }
ProgrammLesson >> duration: anObject [
	duration := anObject
]

{ #category : #comparing }
ProgrammLesson >> hash [
	^ self name hash hashMultiply
]

{ #category : #accessing }
ProgrammLesson >> id [
	^ id
]

{ #category : #accessing }
ProgrammLesson >> id: anObject [
	id := anObject
]

{ #category : #'as yet unclassified' }
ProgrammLesson >> name [ 
^name
]

{ #category : #accessing }
ProgrammLesson >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
ProgrammLesson >> printOn: aStream [ 
aStream << self name
]

{ #category : #accessing }
ProgrammLesson >> type [
	^ type
]

{ #category : #accessing }
ProgrammLesson >> type: anObject [
	type := anObject
]
