API
deleteLesson: aSubjectLesson
	| format path|
	format := {self subjectGrade id.
			self id.
			aSubjectLesson id.}.
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}' format: format.
	self client path: path; delete.
	^self client response.