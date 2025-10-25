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
ObsidianImporter >> absenceExecutions [
	| groups result subjectKeys groupKeys mapped lessonKeys |
	mapped := self grades collect: self gradeStencil.

	groupKeys := mapped collect: #group at.
	subjectKeys := mapped collect: #subject at.
	lessonKeys := mapped collect: #lesson at.
	groups := groupKeys & self connection groups.
	result := groups
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
										-> ((students
												collect: [ :student | 
													| dict task |
													dict := raw detect: [ :each | (each at: #student) = student ].
													task := ({(dict at: #task)} & lesson tasks) first.
													GradeExecution new
														importer: self;
														subject: subject;
														lesson: lesson;
														student: student;
														task: task;
														grade: (dict at: #grade ifAbsent: [5])
													 ]) groupedBy: #task)  ].
						subject -> gradesAssoc asDictionary ].
			group -> subjectTableAssoc asDictionary ].
	^result asDictionary
]

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
	| groups result subjectKeys groupKeys mapped taskKeys |
	mapped := self grades collect: self gradeStencil.

	groupKeys := mapped collect: #group at.
	subjectKeys := mapped collect: #subject at.
	taskKeys := mapped collect: #task at.
	groups := groupKeys & self connection groups.
	result := groups
			collect: [ :group | 
				| subjectTableAssoc subjs |
				subjs := subjectKeys & group activeJournal scheduleSubjects.
				subjectTableAssoc := subjs
						collect: [ :subject | 
							| tasks gradesAssoc table |
							table := subject subjectTable.
							tasks := taskKeys & (table lessons flatCollect: #tasks).
							gradesAssoc := tasks
									collect: [ :task | 
										| lesson raw |
										lesson := table lessons detect: [ :each | each tasks includes: task ].
										raw := mapped
												select: [ :each | 
													{(each at: #task) = task.
													 (each at: #group) = group.
													 (each at: #subject) = subject} allSatisfy: #value ].
										(lesson -> task) -> (raw
											collect: [ :each | 
												| student grade |
												student := ({each at: #student} & table students) first.
												grade := GradeExecution numToWord: (each at: #grade ifAbsent: [ 5 ]).
												GradeExecution new
													importer: self; 
													subject: subject;
													lesson: lesson;
													student: student;
													task: task;
													grade: grade ])
													].
							table -> gradesAssoc asDictionary ].
				group -> subjectTableAssoc asDictionary ].
	^ result asDictionary
]

{ #category : #accessing }
ObsidianImporter >> gradeStencil [
	^ [ :each | 
	| firstLast |
	firstLast := ' ' split: each student jsonObject.
	Dictionary new
		at: #task put: (SubjectTask new name: each task jsonObject);
		at: #subject put: (StudySubject new name: each subject jsonObject);
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
	"	^self gradeExecutions gtTreeFor: aView context"

	<gtView>
	| executions |
	executions := self gradeExecutions.
	aContext at: #gtTreeExpansionLevel ifAbsentPut: [ true ].
	^ aView forward
		title: 'Новые оценки';
		object: [ executions ];
		view: #gtTreeFor:context:; 
		actionButtonLabel: 'Импортировать'
			action: [ :element | 
				element phlow spawnObject: (self importGrades: executions). ]
]

{ #category : #accessing }
ObsidianImporter >> importGrades: aDictionary [
	| tablesToTasks result terminatable |
	tablesToTasks := aDictionary associations
			flatCollect: [ :each | each value associations ].
	terminatable := tablesToTasks asAsyncStream terminatable.
	result := terminatable
		flatCollect: [ :pair | 
			| table lessonsToTasks |
			table := pair key.
			lessonsToTasks := pair value.
			lessonsToTasks associations asAsyncStream
				collect: [ :each | 
					| lesson task studentToGrade |
					lesson := each key key.
					task := each key value.
					studentToGrade := (table students
							collect: [ :student | GradeExecution new student: student ]) | each value.
					table studySubject
						forLesson: lesson
						task: task
						grades: studentToGrade ] ].
		^ImportResult new result: (result on: Exception do: [:e | e]); terminateBlock: [terminatable terminate]. 
]
