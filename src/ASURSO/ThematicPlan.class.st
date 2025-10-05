Class {
	#name : #ThematicPlan,
	#superclass : #Object,
	#instVars : [
		'id',
		'editable',
		'name',
		'isApproved',
		'sections',
		'connection'
	],
	#category : #'ASURSO-Model'
}

{ #category : #accessing }
ThematicPlan >> asWorkingProgramm [
	^ WorkingProgramm new
		connection: self connection;
		name: self name;
		topics: self topics
]

{ #category : #'as yet unclassified' }
ThematicPlan >> client [
^ self connection client
]

{ #category : #accessing }
ThematicPlan >> connection [
	^ connection
]

{ #category : #accessing }
ThematicPlan >> connection: anObject [
	connection := anObject
]

{ #category : #accessing }
ThematicPlan >> editable [
	^ editable
]

{ #category : #accessing }
ThematicPlan >> editable: anObject [
	editable := anObject
]

{ #category : #'as yet unclassified' }
ThematicPlan >> gtProgrammTree: aView context: aContext [
	<gtView>
	^ aView columnedTree
		expandUpTo: 1;
		title: 'Наполнение';
		items: [ self topics ];
		children: [ :each | each children ]
]

{ #category : #accessing }
ThematicPlan >> id [
	^ id
]

{ #category : #accessing }
ThematicPlan >> id: anObject [
	id := anObject
]

{ #category : #accessing }
ThematicPlan >> isApproved [
	^ isApproved
]

{ #category : #accessing }
ThematicPlan >> isApproved: anObject [
	isApproved := anObject
]

{ #category : #'as yet unclassified' }
ThematicPlan >> lessons [
	^self topics flatCollect: #lessons
]

{ #category : #accessing }
ThematicPlan >> name [
	^ name
]

{ #category : #accessing }
ThematicPlan >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
ThematicPlan >> printOn: aStream [
aStream << name
]

{ #category : #accessing }
ThematicPlan >> sections [
	^sections.
]

{ #category : #accessing }
ThematicPlan >> sections: anObject [
	sections := anObject
]

{ #category : #accessing }
ThematicPlan >> topics [
	| indexed |
	indexed := self sections
			collectWithIndex: [ :section :i | 
				(section at: #topics)
					collectWithIndex: [ :topic :j | 
						| lessons |
						lessons := (topic at: #lessons)
								collect: [ :lesson | 
									ProgrammLesson new
										connection: self connection;
										duration: (lesson at: #duration);
										id: (lesson at: #id);
										name: (lesson at: #name) ].
						ProgrammTopic new
							index: j;
							sectionIndex: i;
							name: (topic at: #name);
							lessons: lessons ] ].
	^ indexed flatten
]
