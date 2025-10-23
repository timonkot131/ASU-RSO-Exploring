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
ObsidianImporter >> gradeExecutions [
	| groups result subjectKeys groupKeys mapped lessonKeys |
	mapped := self grades collect: self gradeStencil.

	groupKeys := mapped collect: #group at.
	subjectKeys := mapped collect: #subject at.
	lessonKeys := mapped collect: #lesson at.
	groups := groupKeys & self connection groups.
	^groups
		collect: [ :group | 
			| subjectTableAssoc subjs |
			subjs := subjectKeys & group activeJournal scheduleSubjects.
			subjectTableAssoc := subjs
					collect: [ :subject | 
						| lessons gradesAssoc table lessonGroup |
						table := subject subjectTable.
						lessons := lessonKeys & table lessons.
						lessonGroup := mapped groupedBy: #lesson at.
						gradesAssoc := lessons
								collect: [ :lesson | 
									| keys students raw |
									raw := lessonGroup at: lesson.
									keys := raw collect: #student at.
									students := keys & table students.
									lesson
										-> (students
												collect: [ :student | 
													| dict |
													dict := raw detect: [ :each | (each at: #student) = student ].
													GradeExecution new
														importer: self;
														subject: subject;
														lesson: lesson;
														student: student;
														grade: (dict at: #grade ifAbsent: [5])
													 ]) ].
						subject -> gradesAssoc asDictionary ].
			group -> subjectTableAssoc asDictionary ] 
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

{ #category : #views }
ObsidianImporter >> gtGradeView: aView context: aContext [
	<gtView>
"	^self gradeExecutions gtTreeFor: aView context"
	aContext at: #gtTreeExpansionLevel ifAbsentPut: [ true ].
	^ aView forward
		title: 'Новые оценки';
		object: [ self gradeExecutions ];
		view: #gtTreeFor:context:.
]
