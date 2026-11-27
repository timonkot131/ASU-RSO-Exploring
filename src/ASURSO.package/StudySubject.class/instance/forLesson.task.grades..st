API
forLesson: aSubjectLesson task: aSubjectTask grades: aCollectionOfGradeExecution
	| format path requiredMarks attachments |
	format := {self subjectGrade id.
			self id.
			aSubjectLesson id.
			aSubjectTask id}.
	requiredMarks := Dictionary new
			in: [ :dict | 
				aCollectionOfGradeExecution
					do: [ :execution | 
						dict
							at: execution student id asString
							put: {'isRequired' -> aSubjectTask isRequired.
									'value' -> execution grade} asDictionary ].
				STONJSON toString: dict ].
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}/tasks/{4}'
			format: format.

	self client
		resetEntity;
		path: path.
	attachments := STONJSON toString: aSubjectTask attachments.
	self client multiPartFormDataEntity
		addPart: (ZnMimePart fieldName: 'id' value: aSubjectTask id asString);
		addPart: (ZnMimePart fieldName: 'attachments' value: attachments);
		addPart: (ZnMimePart fieldName: 'alreadyUploadedFiles' value: attachments);
		addPart: (ZnMimePart fieldName: 'type' value: aSubjectTask type);
		addPart: (ZnMimePart fieldName: 'topic' value: aSubjectTask name);
		addPart: (ZnMimePart fieldName: 'marks' value: requiredMarks).
	self client put.
	^ExecutionStatus new 
		client: self client;
		response: self client response;
		lesson: aSubjectLesson;
		subject: self;
		task: aSubjectTask;
		data: aCollectionOfGradeExecution;
		group: self subjectGrade studentGroup.