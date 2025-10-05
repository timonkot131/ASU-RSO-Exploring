Class {
	#name : #WorkingProgramm,
	#superclass : #Object,
	#instVars : [
		'id',
		'name',
		'topics',
		'isApproved',
		'connection'
	],
	#category : #'ASURSO-Model'
}

{ #category : #accessing }
WorkingProgramm >> connection [
	^ connection
]

{ #category : #accessing }
WorkingProgramm >> connection: anObject [
	connection := anObject
]

{ #category : #views }
WorkingProgramm >> gtProgrammTree: aView context: aContext [
	<gtView>
	^ aView columnedTree
		expandUpTo: 1;
		title: 'Наполнение';
		items: [ self topics ];
		children: [ :each | each children ]
]

{ #category : #accessing }
WorkingProgramm >> id [
	^ id
]

{ #category : #accessing }
WorkingProgramm >> id: anObject [
	id := anObject
]

{ #category : #accessing }
WorkingProgramm >> isApproved [
	^ isApproved
]

{ #category : #accessing }
WorkingProgramm >> isApproved: anObject [
	isApproved := anObject
]

{ #category : #accessing }
WorkingProgramm >> name [
	^ name
]

{ #category : #accessing }
WorkingProgramm >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
WorkingProgramm >> printOn: aStream [ 
aStream << self name
]

{ #category : #accessing }
WorkingProgramm >> topics [
	^ topics
]

{ #category : #accessing }
WorkingProgramm >> topics: anObject [
	topics := anObject
]
