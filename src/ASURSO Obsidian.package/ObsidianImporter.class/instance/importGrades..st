accessing
importGrades: aDictionary
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
					studentToGrade := (each value) | (table students
							collect: [ :student | 
								GradeExecution new 
								 student: student;
								 task: task;
								 lesson: lesson ]) .
					table studySubject
						forLesson: lesson
						task: task
						grades: studentToGrade ] ].
		^GradeImportResult new result: (result on: Exception do: [:e | e]); terminateBlock: [terminatable terminate]. 