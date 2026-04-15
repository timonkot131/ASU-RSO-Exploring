Class {
	#name : 'ObsidianAttendance',
	#superclass : 'Object',
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'data',
		'announcer'
	],
	#category : 'ASURSO-Model',
	#package : 'ASURSO',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
ObsidianAttendance >> = anObject [
(anObject isKindOf: self class) ifTrue: [
	^((self name = anObject name) and: self group = anObject group)
	 	and: self activity = anObject activity.
].
^false 
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> absenceType [
^ObsidianReplica fromObsidianReference: (self data at: #'Тип отсутствия') 
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> absenceType: aString [
self data at: #'Тип отсутствия' put: (ObsidianReplica asObsidianReference:  aString).
self announce: ObsidianAttendanceUpdate.
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> activity [
^ObsidianReplica fromObsidianReference: (self data at: #Занятие) 
]

{ #category : 'announcer' }
ObsidianAttendance >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> asElement [
	^ BlElement new
		in: [ :anElement | anElement userData at: #data put: self ];
		border: (BlBorder paint: Color black width: 1);
		layout: BlFrameLayout new;
		addChild: self textElement;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		when: BlClickEvent do: [ self nextAbsence ];
		in: [ :anElement | 
			self
				when: ObsidianAttendanceUpdate
				do: [ anElement removeChildren.
					anElement addChild: self textElement ] ];
		yourself
]

{ #category : 'accessing' }
ObsidianAttendance >> data [
	^ data
]

{ #category : 'accessing' }
ObsidianAttendance >> data: anObject [
	data := anObject
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> group [
^ObsidianReplica fromObsidianReference: (self data at: #Группа) 
]

{ #category : 'views' }
ObsidianAttendance >> gtViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Live';
		object: [ self asElement ];
		view: #gtLiveFor:
]

{ #category : 'comparing' }
ObsidianAttendance >> hash [
	^ (self name hash hashMultiply bitXor: self group hash hashMultiply)
		bitXor: self activity hash hashMultiply
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> initialize [
announcer := Announcer new.
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> isForExport [ 
^(self absenceType = '') not
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> name [
^ObsidianReplica fromObsidianReference: (self data at: #Имя) 
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> nextAbsence [
self data at: #'Тип отсутствия' update: [:anItem |
	ObsidianReplica asObsidianReference: (
	{
	'' -> 'Отсутствует'.
	'Отсутствует' -> 'Опоздал'	.
	'Опоздал' -> 'Заболел'.
	'Заболел' ->'Заявление'.
	'Заявление' -> ''.
} asDictionary at: (ObsidianReplica fromObsidianReference: anItem))].
self announce: ObsidianAttendanceUpdate.
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> printOn: aStream [
aStream << (self group, '; ').
aStream << (self name, '; ').
aStream << (self activity, '; ').
aStream << (self absenceType)
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> switchAttendanceType [
^{
	'Заболел' -> 'Б'.
	'Отсутствует' -> 'Н'.
	'Заявление' -> 'З'.
	'Опоздал' -> 'О'.
	'' -> ''. "Присутствовал"
} asDictionary at: self absenceType.
]

{ #category : 'as yet unclassified' }
ObsidianAttendance >> textElement [
	^ BlTextElement new
		text: self switchAttendanceType asRopedText;
		constraintsDo: [ :c | 
			c frame vertical alignCenter.
			c frame horizontal alignCenter ]
]
