views
gtLessonsFor: aView
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