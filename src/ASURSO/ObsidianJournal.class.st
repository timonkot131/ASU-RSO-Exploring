Class {
	#name : 'ObsidianJournal',
	#superclass : 'Object',
	#instVars : [
		'source',
		'items',
		'element',
		'replica'
	],
	#category : 'ASURSO-Model',
	#package : 'ASURSO',
	#tag : 'Model'
}

{ #category : 'accessing' }
ObsidianJournal >> element [
	^ element
]

{ #category : 'accessing' }
ObsidianJournal >> element: anObject [
	element := anObject
]

{ #category : 'views' }
ObsidianJournal >> gtViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Live';
		object: [ self element ];
		view: #gtLiveFor:
]

{ #category : 'accessing' }
ObsidianJournal >> items [
	^ items
]

{ #category : 'accessing' }
ObsidianJournal >> items: anObject [
	items := anObject
]

{ #category : 'accessing' }
ObsidianJournal >> replica [
	^ replica
]

{ #category : 'accessing' }
ObsidianJournal >> replica: anObject [
	replica := anObject
]

{ #category : 'accessing' }
ObsidianJournal >> source [
	^ source
]

{ #category : 'accessing' }
ObsidianJournal >> source: anObject [
	source := anObject
]
