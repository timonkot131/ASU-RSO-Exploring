Class {
	#name : #AsuAbsenceReason,
	#superclass : #Object,
	#instVars : [
		'reason'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
AsuAbsenceReason class >> isLate [
	^ self new reason: 'IsLate'
]

{ #category : #'as yet unclassified' }
AsuAbsenceReason class >> isPresent [
	^ self new reason: nil.
]

{ #category : #'as yet unclassified' }
AsuAbsenceReason class >> noValidReason [
	^ self new reason: 'IsAbsentByNotValidReason'
]

{ #category : #'as yet unclassified' }
AsuAbsenceReason class >> sickLeave [
	^ self new reason:  'SickLeave'
]

{ #category : #'as yet unclassified' }
AsuAbsenceReason class >> validReason [
	^ self new reason: 'IsAbsentByValidReason'
]

{ #category : #accessing }
AsuAbsenceReason >> reason [
	^ reason
]

{ #category : #accessing }
AsuAbsenceReason >> reason: anObject [
	reason := anObject
]
