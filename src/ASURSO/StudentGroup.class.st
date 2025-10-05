Class {
	#name : #StudentGroup,
	#superclass : #Object,
	#instVars : [
		'code',
		'yearNumber',
		'name',
		'id',
		'connection'
	],
	#category : #'ASURSO-Model'
}

{ #category : #accessing }
StudentGroup >> activeJournal [
	^ self journal detect: #isActive
]

{ #category : #accessing }
StudentGroup >> client [
	^ connection client
]

{ #category : #accessing }
StudentGroup >> code [
	^ code
]

{ #category : #accessing }
StudentGroup >> code: anObject [
	code := anObject
]

{ #category : #accessing }
StudentGroup >> connection [
	^ connection
]

{ #category : #accessing }
StudentGroup >> connection: anObject [
	connection := anObject
]

{ #category : #'as yet unclassified' }
StudentGroup >> courses [
	| items |
	self client path: ('/services/journal/gradebook/{1}/entries' format: {self id}).
	items := self client
			withStreaming: [ | znStream |
				znStream := ZnCharacterReadStream on: self client get.
				(NeoJSONReader on: znStream)
					for: #Courses
						customDo: (connection injectMapping: StudentGrade);
					for: StudentGrade
						do: [ :m | 
							m mapInstVars.
							(m mapInstVar: 'scheduleSubjects') valueSchema: #Subjects ];
					for: #Subjects
						customDo: (connection injectMapping: StudySubject);
					for: StudySubject do: #mapInstVars;
					nextAs: #Courses ].
	items do: [:c | c scheduleSubjects do: [:s | s subjectGrade: c ]].
	^items
]

{ #category : #views }
StudentGroup >> gtView1For: aView [
	<gtView>
	^ aView forward
		title: 'Текущий журнал';
		priority: 10;
		object: [ self journal detect: #isActive ];
		view: #gtScheduleSubjectsFor:
]

{ #category : #views }
StudentGroup >> gtView2For: aView [
	<gtView>
	^ aView forward
		priority: 5;
		
		title: 'Решения для бизнеса';
		object: [ self activeJournal scheduleSubjects
				detect: [ :x | x name includesSubstring: 'решения для бизнеса' ] ];
		view: #gtPairsFor:
]

{ #category : #views }
StudentGroup >> gtView3For: aView [
	<gtView>
	^ aView forward
		priority: 7;
		title: 'Инструментальные средства';
		object: [ self activeJournal scheduleSubjects
				detect: [ :x | x name includesSubstring: 'Инструментальные средства' ] ];
		view: #gtPairsFor:
]

{ #category : #views }
StudentGroup >> gtViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Журнал';
		priority: 20;
		object: [ self journal ];
		view: #gtItemsFor:
]

{ #category : #accessing }
StudentGroup >> id [
	^ id
]

{ #category : #accessing }
StudentGroup >> id: anObject [
	id := anObject
]

{ #category : #'as yet unclassified' }
StudentGroup >> journal [
	| items |
	self client path: ('/services/journal/gradebook/{1}/entries' format: {self id}).
	items := self client
			withStreaming: [ | znStream |
				znStream := ZnCharacterReadStream on: self client get.
				(NeoJSONReader on: znStream)
					for: #Courses
						customDo: (connection injectMapping: StudentGrade);
					for: StudentGrade
						do: [ :m | 
							m mapInstVars.
							(m mapInstVar: 'scheduleSubjects') valueSchema: #Subjects ];
					for: #Subjects
						customDo: (connection injectMapping: StudySubject);
					for: StudySubject do: #mapInstVars;
					nextAs: #Courses ].
	items do: [:c | 
		c studentGroup: self.
		c scheduleSubjects do: [:s | s subjectGrade: c ]].
	^items
]

{ #category : #accessing }
StudentGroup >> name [
	^ name
]

{ #category : #accessing }
StudentGroup >> name: anObject [
	name := anObject
]

{ #category : #accessing }
StudentGroup >> printOn: aStream [
	^ aStream
		<< ('Название: {1}, ID: {2}'
				format: {name.
						id})
]

{ #category : #accessing }
StudentGroup >> yearNumber [
	^ yearNumber
]

{ #category : #accessing }
StudentGroup >> yearNumber: anObject [
	yearNumber := anObject
]
