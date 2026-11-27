accessing
attendanceStencil
	^ [ :each | 
	| firstLast |
	firstLast := ' ' split: each student jsonObject.
	Dictionary new
		at: #subject put: (StudySubject new name: each subject jsonObject);
		at: #type put: (self attendanceSwitch: each type jsonObject);
		at: #lesson put: (SubjectLesson new name: each lesson jsonObject);
		at: #group put: (StudentGroup new name: each group jsonObject);
		at: #student
			put: (SubjectStudent new
					lastName: firstLast first;
					firstName: firstLast second);
		yourself ]