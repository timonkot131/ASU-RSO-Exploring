Class {
	#name : 'ObsidianJournal',
	#superclass : 'Object',
	#instVars : [
		'source',
		'items',
		'element',
		'replica',
		'title',
		'sourced'
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
		actionButtonIcon: BrGlamorousVectorIcons savetodisk 
			 action: [self replica export: (((self items | self sourced) select: #isForExport thenCollect: #data) ) source: self source];
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

{ #category : 'as yet unclassified' }
ObsidianJournal >> printOn: aStream [
aStream << self title
]

{ #category : 'as yet unclassified' }
ObsidianJournal >> printString [
^self title
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

{ #category : 'accessing' }
ObsidianJournal >> sourced [
	^ sourced
]

{ #category : 'accessing' }
ObsidianJournal >> sourced: anObject [
	sourced := anObject
]

{ #category : 'accessing' }
ObsidianJournal >> title [
	^ title
]

{ #category : 'accessing' }
ObsidianJournal >> title: anObject [
	title := anObject
]
