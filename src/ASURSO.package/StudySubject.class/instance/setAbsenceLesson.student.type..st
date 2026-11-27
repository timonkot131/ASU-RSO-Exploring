API
setAbsenceLesson: aSubjectLesson student: aSubjectUser type: anAsuAbsenceReason
	| format path |
	format := {self subjectGrade id.
			self id.
			aSubjectLesson id.
			aSubjectUser id}.
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}/students/{4}'
			format: format.
	self client path: path ;
		entity: (ZnEntity json: (STONJSON toString: (self absentEntityOf: anAsuAbsenceReason )));
		put.
	^self client response