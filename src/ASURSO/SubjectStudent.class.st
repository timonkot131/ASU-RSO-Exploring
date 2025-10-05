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

{ #category : #accessing }
SubjectStudent >> contains: aString [
	^ self fullName includesSubstring: aString
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
