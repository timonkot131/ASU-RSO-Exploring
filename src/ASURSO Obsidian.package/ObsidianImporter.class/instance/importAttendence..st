accessing
importAttendence: aDictionary
	| tablesToTasks result terminatable |
	tablesToTasks := aDictionary associations
			flatCollect: [ :each | each value associations ].
	terminatable := tablesToTasks asAsyncStream terminatable .
	result := terminatable
		flatCollect: [ :pair | 
			| table lessons |
			table := pair key.
			lessons := pair value.
			lessons associations asAsyncStream
				collect: [ :each |  
					| lesson  studentToGrade |
					lesson := each key.
					studentToGrade := (each value) | (table students
							collect: [ :student | GradeExecution new student: student ]) .
					table studySubject
						forLesson: lesson
						attendance: studentToGrade ] ].
		^AttendanceImportResult new result: (result "on: Exception do: [:e | e]"); terminateBlock: [terminatable terminate]. 