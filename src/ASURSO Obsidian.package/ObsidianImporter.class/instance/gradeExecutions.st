accessing
gradeExecutions
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
									flatCollect: [ :task | 
										| lessons  |
										lessons := table lessons select: [ :each | each tasks includes: task ].									
										lessons collect: [ :lesson |
											| raw lessonTask |
											lessonTask := ({task} & lesson tasks) first.
											raw := mapped
												select: [ :each | 
													{(each at: #task) = task.
													 (each at: #group) = group.
													 (each at: #subject) = subject} allSatisfy: #value ].
											(lesson -> lessonTask) -> (raw
												collect: [ :each | 
													| student grade |
													[student := ({each at: #student} & table students) first.] on: Exception do: [:e |
														(Error error: 'Такого студента нету в группе')].
												
												grade := GradeExecution numToWord: (each at: #grade ifPresent: #asInteger ifAbsent: [ 5 ]).
												
												GradeExecution new
													importer: self; 
													subject: subject;
													lesson: lesson;
													student: student;
													task: lessonTask;
													grade: grade ]) ]
													].
							table -> gradesAssoc asDictionary ].
				group -> subjectTableAssoc asDictionary ].
	^ result asDictionary