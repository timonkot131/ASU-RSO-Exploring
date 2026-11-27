API
removeTaskForLesson: aSubjectLesson
	^aSubjectLesson tasks
		collect: [ :each | 
			| format path |
			format := {self subjectGrade id.
					self id.
					aSubjectLesson id.
					each id}.
			path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}/tasks/{4}'
					format: format.
			self client
				path: path;
				delete. ]