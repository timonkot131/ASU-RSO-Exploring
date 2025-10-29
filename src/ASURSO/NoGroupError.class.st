Class {
	#name : #NoGroupError,
	#superclass : #Error,
	#instVars : [
		'view',
		'object'
	],
	#category : #'ASURSO-Exceptions'
}

{ #category : #'as yet unclassified' }
NoGroupError >> asDebuggableElement [
	^ PhlowDebuggableElementStencil new
		freeze: self; 
		object: self object;
		view: self view;
		asElement. 
]

{ #category : #accessing }
NoGroupError >> object [
	^ object
]

{ #category : #accessing }
NoGroupError >> object: anObject [
	object := anObject
]

{ #category : #accessing }
NoGroupError >> view [
	^ view
]

{ #category : #accessing }
NoGroupError >> view: anObject [
	view := anObject
]
