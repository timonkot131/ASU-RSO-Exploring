Class {
	#name : #SubjectTask,
	#superclass : #Object,
	#instVars : [
		'name',
		'file',
		'id',
		'type',
		'attachments'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
SubjectTask >> = anObject [
(anObject isKindOf: self class) ifFalse: [^false].
^ self name = anObject name
]

{ #category : #accessing }
SubjectTask >> attachments [
	^ attachments
]

{ #category : #accessing }
SubjectTask >> attachments: anObject [
	attachments := anObject
]

{ #category : #accessing }
SubjectTask >> file [
	^ file
]

{ #category : #accessing }
SubjectTask >> file: anObject [
	file := anObject
]

{ #category : #views }
SubjectTask >> gtPathFor: aView [
	<gtView>
	^ aView forward
		title: 'Path';
		object: [ self file asFileReference ];
		view: #gtPathFor:
]

{ #category : #comparing }
SubjectTask >> hash [
	^ self name hash hashMultiply
]

{ #category : #accessing }
SubjectTask >> id [
	^ id
]

{ #category : #accessing }
SubjectTask >> id: anObject [
	id := anObject
]

{ #category : #accessing }
SubjectTask >> name [
	^ name
]

{ #category : #accessing }
SubjectTask >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
SubjectTask >> printOn: aStream [
aStream << name
]

{ #category : #accessing }
SubjectTask >> type [
	^ type ifNil: ['PracticalWork']
]

{ #category : #accessing }
SubjectTask >> type: anObject [
	type := anObject
]
