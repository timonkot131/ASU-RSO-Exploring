accessing
gradeStencil
	^ [ :each | 
	| firstLast |
	firstLast := ' ' split: each student jsonObject.
	Dictionary new
		at: #grade put: each grade jsonObject;
		at: #task put: (SubjectTask new name: each task jsonObject);
		at: #subject put: (StudySubject new name: each subject jsonObject);
		at: #group put: (StudentGroup new name: each group jsonObject);
		at: #student
			put: (SubjectStudent new
					lastName: firstLast first;
					firstName: firstLast second);
		yourself ]