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
ObsidianImporter >> gradeStencil [
	^ [ :each | 
	| firstLast |
	firstLast := ' ' split: each student jsonObject.
	Dictionary new
		at: #subject put: (StudySubject new name: each subject jsonObject);
		at: #lesson put: (SubjectLesson new name: each lesson jsonObject);
		at: #group put: (StudentGroup new name: each group jsonObject);
		at: #student
			put: (SubjectStudent new
					lastName: firstLast first;
					firstName: firstLast second);
		yourself ]
]

{ #category : #accessing }
ObsidianImporter >> grades [
	^ (CSV2JSON for: grades contents) json
]

{ #category : #accessing }
ObsidianImporter >> grades: aFileReference [
	grades := aFileReference
]
