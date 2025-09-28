Class {
	#name : #StudentGrade,
	#superclass : #Object,
	#instVars : [
		'client',
		'id',
		'yearNumber',
		'name',
		'isActive',
		'scheduleSubjects',
		'connection',
		'termNumber',
		'termType',
		'startDate',
		'endDate'
	],
	#category : #'ASU-RSO-Model'
}

{ #category : #accessing }
StudentGrade >> client [
	^ connection client
]

{ #category : #accessing }
StudentGrade >> connection [
	^ connection
]

{ #category : #accessing }
StudentGrade >> connection: anObject [
	connection := anObject
]

{ #category : #accessing }
StudentGrade >> endDate [
	^ endDate
]

{ #category : #accessing }
StudentGrade >> endDate: anObject [
	endDate := anObject
]

{ #category : #views }
StudentGrade >> gtScheduleSubjectsFor: aView [
	<gtView>
	scheduleSubjects ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Журналы';
		items: [ scheduleSubjects ];
		column: 'Value' text: [ :each | each gtDisplayString ]
]

{ #category : #accessing }
StudentGrade >> id [
	^ id
]

{ #category : #accessing }
StudentGrade >> id: anObject [
	id := anObject
]

{ #category : #accessing }
StudentGrade >> isActive [
	^ isActive
]

{ #category : #accessing }
StudentGrade >> isActive: anObject [
	isActive := anObject
]

{ #category : #accessing }
StudentGrade >> name [
	^ name
]

{ #category : #accessing }
StudentGrade >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
StudentGrade >> printOn: aStream [
aStream << name
]

{ #category : #accessing }
StudentGrade >> scheduleSubjects [
	^ scheduleSubjects
]

{ #category : #accessing }
StudentGrade >> scheduleSubjects: anObject [
	scheduleSubjects := anObject
]

{ #category : #accessing }
StudentGrade >> startDate [
	^ startDate
]

{ #category : #accessing }
StudentGrade >> startDate: anObject [
	startDate := anObject
]

{ #category : #accessing }
StudentGrade >> termNumber [
	^ termNumber
]

{ #category : #accessing }
StudentGrade >> termNumber: anObject [
	termNumber := anObject
]

{ #category : #accessing }
StudentGrade >> termType [
	^ termType
]

{ #category : #accessing }
StudentGrade >> termType: anObject [
	termType := anObject
]

{ #category : #accessing }
StudentGrade >> yearNumber [
	^ yearNumber
]

{ #category : #accessing }
StudentGrade >> yearNumber: anObject [
	yearNumber := anObject
]
