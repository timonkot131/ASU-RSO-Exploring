Class {
	#name : #ObsidianImporter,
	#superclass : #Object,
	#instVars : [
		'connection',
		'attendance',
		'grades'
	],
	#category : #'ASURSO-Model'
}

{ #category : #accessing }
ObsidianImporter >> attendance [
	^ (CSV2JSON for: attendance contents) json
]

{ #category : #accessing }
ObsidianImporter >> attendance: aFileReference [
	attendance := aFileReference
]

{ #category : #accessing }
ObsidianImporter >> connection [
	^ connection
]

{ #category : #accessing }
ObsidianImporter >> connection: anObject [
	connection := anObject
]

{ #category : #accessing }
ObsidianImporter >> grades [
	^ (CSV2JSON for: grades contents) json
]

{ #category : #accessing }
ObsidianImporter >> grades: aFileReference [
	grades := aFileReference
]
