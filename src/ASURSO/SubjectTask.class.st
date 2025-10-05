Class {
	#name : #SubjectTask,
	#superclass : #Object,
	#instVars : [
		'name',
		'file',
		'id'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
SubjectTask >> = anObject [
(anObject isKindOf: self class) ifFalse: [^false].
^ self name = anObject name
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
SubjectTask >> name [
	^ name
]

{ #category : #accessing }
SubjectTask >> name: anObject [
	name := anObject
]
