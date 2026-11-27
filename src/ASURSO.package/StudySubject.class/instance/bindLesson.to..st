API
bindLesson: aSubjectLesson to: aProgrammLesson
	| preparedEntity format path|
	preparedEntity := ZnEntity
			json: (STONJSON toString: (self prepareBind: aSubjectLesson to: aProgrammLesson)).
	format := {self subjectGrade id.
			self id}.
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons' format: format.
	self client path: path; entity: preparedEntity; post.
	^self client response.