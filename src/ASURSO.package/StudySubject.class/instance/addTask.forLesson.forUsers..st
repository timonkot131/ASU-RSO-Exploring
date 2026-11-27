API
addTask: aSubjectTask forLesson: aSubjectLesson forUsers: anArrayOfSubjectUser
	| format path requiredMarks |
	format := {self subjectGrade id.
			self id.
			aSubjectLesson id}.
	requiredMarks := Dictionary new
			in: [ :dict | 
				anArrayOfSubjectUser
					do: [ :each | 
						dict
							at: each id asString
							put: {'isRequired' -> aSubjectTask isRequired.
									'value' -> nil} asDictionary ].
				STONJSON toString: dict ].
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}/tasks'
			format: format.
	
	self client
		resetEntity;
		path: path.
		(self client multiPartFormDataEntity
				addPart: (ZnMimePart fieldName: 'type' value: aSubjectTask type);
				addPart: (ZnMimePart fieldName: 'topic' value: aSubjectTask name);
				addPart: (ZnMimePart fieldName: 'marks' value: requiredMarks)";
				addPart: (ZnMimePart
						fieldName: 'file'
						fileName: aSubjectTask file basename
						entity: (ZnEntity bytes: aSubjectTask file binaryContents))").
		
	self client post.