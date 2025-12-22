Class {
	#name : #TotalSubjectRow,
	#superclass : #Object,
	#instVars : [
		'firstName',
		'lastName',
		'middleName',
		'id',
		'average',
		'final'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
TotalSubjectRow >> = anObject [
	(anObject isKindOf: SubjectStudent)
		ifTrue: [ ^ self firstLast = anObject firstLast ]
]

{ #category : #accessing }
TotalSubjectRow >> average [
	^ average
]

{ #category : #accessing }
TotalSubjectRow >> average: anObject [
	average := anObject
]

{ #category : #accessing }
TotalSubjectRow >> contains: aString [
	^ self fullName includesSubstring: aString
]

{ #category : #accessing }
TotalSubjectRow >> final [
	^ final
]

{ #category : #accessing }
TotalSubjectRow >> final: anObject [
	final := anObject
]

{ #category : #'as yet unclassified' }
TotalSubjectRow >> firstLast [
	^ self firstName , ' ' , self lastName
]

{ #category : #accessing }
TotalSubjectRow >> firstName [
	^ firstName
]

{ #category : #accessing }
TotalSubjectRow >> firstName: anObject [
	firstName := anObject
]

{ #category : #accessing }
TotalSubjectRow >> fullName [
	^ '{1} {2} {3}'
		format: {lastName.
				firstName.
				middleName}
]

{ #category : #comparing }
TotalSubjectRow >> hash [
	^ self firstLast hash hashMultiply
]

{ #category : #accessing }
TotalSubjectRow >> id [
	^ id
]

{ #category : #accessing }
TotalSubjectRow >> id: anObject [
	id := anObject
]

{ #category : #accessing }
TotalSubjectRow >> lastName [
	^ lastName
]

{ #category : #accessing }
TotalSubjectRow >> lastName: anObject [
	lastName := anObject
]

{ #category : #accessing }
TotalSubjectRow >> middleName [
	^ middleName
]

{ #category : #accessing }
TotalSubjectRow >> middleName: anObject [
	middleName := anObject
]

{ #category : #'as yet unclassified' }
TotalSubjectRow >> printOn: aStream [ 
aStream << ('{1} {2}' format: {self lastName. self firstName})
]
