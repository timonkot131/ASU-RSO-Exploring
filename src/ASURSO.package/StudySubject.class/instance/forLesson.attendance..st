API
forLesson: aSubjectLesson attendance: aCollection
	| format path requiredMarks |
	format := {self subjectGrade id.
			self id.
			aSubjectLesson id}.
	requiredMarks := aCollection
			collect: [ :each | 
				| dict |
				dict := Dictionary new.
				each absenceType reason
					ifNotNil: [ :reason | dict at: #absenceType put: reason ].
				dict
					at: #id put: each student id;
					yourself ].
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}/mark-as-absent'
			format: format.
	self client
		path: path;
		entity: (ZnEntity
				json: (STONJSON
						toString: (Dictionary new
								at: #studentsWithAbsenceType put: requiredMarks;
								yourself)));
		post.

	^ ExecutionStatus new
		client: self client;
		response: self client response;
		lesson: aSubjectLesson;
		subject: self;
		data: aCollection;
		group: self subjectGrade studentGroup