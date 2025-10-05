Class {
	#name : #ProgrammTopic,
	#superclass : #Object,
	#instVars : [
		'name',
		'sectionIndex',
		'index',
		'lessons'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
ProgrammTopic >> children [ 
	^self lessons
]

{ #category : #views }
ProgrammTopic >> gtLessonsFor: aView [
	<gtView>
	lessons ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Lessons';
		items: [ lessons ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #accessing }
ProgrammTopic >> index [
	^ index
]

{ #category : #accessing }
ProgrammTopic >> index: anObject [
	index := anObject
]

{ #category : #'as yet unclassified' }
ProgrammTopic >> isCollection [ ^true
]

{ #category : #accessing }
ProgrammTopic >> lessons [
	^ lessons
]

{ #category : #accessing }
ProgrammTopic >> lessons: anObject [
	lessons := anObject
]

{ #category : #accessing }
ProgrammTopic >> name [
	^ name
]

{ #category : #accessing }
ProgrammTopic >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
ProgrammTopic >> printOn: aStream [
aStream << ('{1}.{2}: {3}' format: {self sectionIndex. self index. self name})
]

{ #category : #accessing }
ProgrammTopic >> sectionIndex [
	^ sectionIndex
]

{ #category : #accessing }
ProgrammTopic >> sectionIndex: anObject [
	sectionIndex := anObject
]
