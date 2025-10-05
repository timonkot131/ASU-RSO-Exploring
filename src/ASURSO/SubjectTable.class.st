Class {
	#name : #SubjectTable,
	#superclass : #Object,
	#instVars : [
		'lessons',
		'students',
		'studySubject',
		'connection',
		'workingProgram'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
SubjectTable >> cleanTasks: aSubjectLeson [
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
SubjectTable >> gtLessonsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Пары';
		items: [ lessons ];
		actionButtonLabel: 'Стереть все задания' action: [ :element |
			self lessons do: [:each |  
			self studySubject removeTaskForLesson: each].
			element phlow fireViewUpdateWish
		];
		withMultipleSelection;
		column: 'Дата'
			text: #dateString
			width: 100;
		column: 'Название'
			text: [:each | (each tasks size > 0) ifTrue: [each name asRopedText foreground: Color blue] ifFalse: [each name]]
			width: 440;
		column: 'Задание' text: #taskString;
		in: [ :view | 
			self connection tasks
				do: [ :each | 
					view
					    contextItemLabel: 'Добавить ' , each name
						action: [ :element :lesson  | 
						view.
						self studySubject
								removeTaskForLesson: lesson;
								addTask: each forLesson: lesson forUsers: self students.
						element phlow fireViewUpdateWish
						] ].
			view contextItemLabel: 'Удалить задание' action: [ :element :lesson | 
				self studySubject removeTaskForLesson: lesson.
				element phlow fireViewUpdateWish
			] ]
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
