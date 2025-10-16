Class {
	#name : #SubjectStudent,
	#superclass : #Object,
	#instVars : [
		'firstName',
		'lastName',
		'middleName',
		'id'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
SubjectStudent >> = anObject [
	(anObject isKindOf: SubjectStudent)
		ifTrue: [ ^ self firstLast = anObject firstLast ]
]

{ #category : #accessing }
SubjectStudent >> contains: aString [
	^ self fullName includesSubstring: aString
]

{ #category : #'as yet unclassified' }
SubjectStudent >> firstLast [
	^ self firstName , ' ' , self lastName
]

{ #category : #accessing }
SubjectStudent >> firstName [
	^ firstName
]

{ #category : #accessing }
SubjectStudent >> firstName: anObject [
	firstName := anObject
]

{ #category : #accessing }
SubjectStudent >> fullName [
	^ '{1} {2} {3}'
		format: {lastName.
				firstName.
				middleName}
]

{ #category : #comparing }
SubjectStudent >> hash [
	^ self firstLast hash hashMultiply
]

{ #category : #accessing }
SubjectStudent >> id [
	^ id
]

{ #category : #accessing }
SubjectStudent >> id: anObject [
	id := anObject
]

{ #category : #accessing }
SubjectStudent >> lastName [
	^ lastName
]

{ #category : #accessing }
SubjectStudent >> lastName: anObject [
	lastName := anObject
]

{ #category : #accessing }
SubjectStudent >> middleName [
	^ middleName
]

{ #category : #accessing }
SubjectStudent >> middleName: anObject [
	middleName := anObject
]

{ #category : #'as yet unclassified' }
SubjectStudent >> printOn: aStream [ 
aStream << ('{1} {2}' format: {self lastName. self firstName})
]
