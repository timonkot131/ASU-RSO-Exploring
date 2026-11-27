accessing
attendanceExecutions
	| groups result subjectKeys groupKeys mapped lessonKeys |
	mapped := (self attendance collect: self attendanceStencil).

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
										-> (students
												collect: [ :student | 
													| dict |
													dict := raw detect: [ :each | (each at: #student) = student ].
													GradeExecution new
														importer: self;
														subject: subject;
														lesson: lesson;
														student: student;
														absenceType: (dict at: #type).
														
																																						 ])  ].
						table -> gradesAssoc asDictionary ].
			group -> subjectTableAssoc asDictionary ].
	^result asDictionary 