Class {
	#name : #SubjectTable,
	#superclass : #Object,
	#instVars : [
		'lessons',
		'students',
		'studySubject',
		'connection',
		'workingProgram',
		'teacher'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
SubjectTable >> cleanTasks: aSubjectLeson [
]

{ #category : #views }
SubjectTable >> clearAllTasks [
	self lessons do: [ :each | self studySubject removeTaskForLesson: each ]
]

{ #category : #'as yet unclassified' }
SubjectTable >> client [ 
^ connection client
]

{ #category : #accessing }
SubjectTable >> connection [
	^ connection
]

{ #category : #accessing }
SubjectTable >> connection: anObject [
	connection := anObject
]

{ #category : #views }
SubjectTable >> gtBadAttendance: aView [
	<gtView>
	^ aView forward
		title: 'Прогульщики';
		object: [ (self students
				collect: [ :student | 
					student
						-> (self lessons
								count: [ :lesson | 
									lesson absent
										at: student
										ifPresent: [ :value | value = AsuAbsenceReason noValidReason reason ]
										ifAbsent: [ false ] ]) ]) sort: #value descending ];
		view: #gtItemsFor:
]

{ #category : #views }
SubjectTable >> gtLessonsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Пары';
		items: [ lessons ];
	
		column: 'Дата'
			text: #dateString
			width: 100;
		column: 'Название'
			text: [ :each | 
				
				each tasks size > 0
					ifTrue: [ each name asRopedText foreground: Color blue ]
					ifFalse: [ each name ] ]
			width: 440;
		column: 'Задание' text: #taskString;
		in: [ :view | 
			(self workingProgramm lessons difference: self lessons)
				do: [ :each | 
					view
						contextItemLabel: each name
						action: [ :element :lesson | 
							self studySubject bindLesson: lesson to: each.
							element phlow fireViewUpdateWish ] ].
			self connection tasks
				do: [ :each | 
					view
						contextItemLabel: 'Добавить ' , each name
						action: [ :element :lesson | 
							view.
							self studySubject
								removeTaskForLesson: lesson;
								addTask: each
									forLesson: lesson
									forUsers: self students.
							element phlow fireViewUpdateWish ] ].
			view
				contextItemLabel: 'Удалить занятие' action: [:element :lesson | 
					self studySubject deleteLesson: lesson.
					element phlow fireViewUpdateWish.
				];
				contextItemLabel: 'Удалить задание'
				action: [ :element :lesson | 
					self studySubject removeTaskForLesson: lesson.
					element phlow fireViewUpdateWish ] ]
]

{ #category : #views }
SubjectTable >> gtStudentsFor: aView [
	<gtView>
	^ aView forward
		title: 'Студенты';
		object: [ students ];
		view: #gtItemsFor:
]

{ #category : #views }
SubjectTable >> gtTeacherFor: aView [
	<gtView>
	^ aView forward
		title: 'Преподаватель';
		object: [ teacher ];
		view: #gtStringFor:
]

{ #category : #views }
SubjectTable >> gtWorkingProgramFor: aView [
	<gtView>
	^ aView forward
		title: 'WorkingProgram наполнение';
		object: [ workingProgram ];
		view: #gtProgrammTree:context:
]

{ #category : #accessing }
SubjectTable >> lessons [
	^ lessons
]

{ #category : #accessing }
SubjectTable >> lessons: anObject [
	lessons := anObject
]

{ #category : #printing }
SubjectTable >> printOn: aStream [
self studySubject printOn: aStream.
]

{ #category : #accessing }
SubjectTable >> students [
	^ students
]

{ #category : #accessing }
SubjectTable >> students: anObject [
	students := anObject
]

{ #category : #accessing }
SubjectTable >> studySubject [
	^ studySubject
]

{ #category : #accessing }
SubjectTable >> studySubject: anObject [
	studySubject := anObject
]

{ #category : #accessing }
SubjectTable >> workingProgramm [
	^ workingProgram
]

{ #category : #accessing }
SubjectTable >> workingProgramm: anObject [
	workingProgram := anObject
]
