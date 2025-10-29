Class {
	#name : #PhlowDebuggableElementStencil,
	#superclass : #BrDebuggableElementStencil,
	#instVars : [
		'view',
		'object'
	],
	#category : #'ASURSO-Exceptions'
}

{ #category : #'as yet unclassified' }
PhlowDebuggableElementStencil >> create [
	<return: #BlElement>
	| aLabel aButton aContainer |
	aLabel := self object perform: self view with: GtPhlowView empty.
	aButton := self createDebugButton.
	aContainer := BlElement new
		layout: BlLinearLayout horizontal;
		height: 400;
		constraintsDo: [ :c | 
			c horizontal fitContentLimited.
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		addChildren: {aLabel asElement. aButton}.
	^ BrFrame new
		matchParent;
		addChild: aContainer;
		in: [ :anElement | 
			anElement userData at: #exception put: self exception ];
		yourself
]

{ #category : #accessing }
PhlowDebuggableElementStencil >> object [
	^ object
]

{ #category : #accessing }
PhlowDebuggableElementStencil >> object: anObject [
	object := anObject
]

{ #category : #accessing }
PhlowDebuggableElementStencil >> view [
	^ view
]

{ #category : #accessing }
PhlowDebuggableElementStencil >> view: anObject [
	view := anObject
]
