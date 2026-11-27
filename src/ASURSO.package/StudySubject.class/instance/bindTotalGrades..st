API
bindTotalGrades: anArrayOfTotalSubjectRow
	| preparedEntity format path |
	preparedEntity := ZnEntity
			json: (STONJSON
					toString: (Dictionary new
							in: [ :dic | 
								anArrayOfTotalSubjectRow
									do: [ :aRow | 
										| grade |
											(aRow average isZero or: [aRow average rounded = 2] ) ifFalse: [
										grade := GradeExecution numToWord: aRow average rounded.
									
											dic
												at: aRow id asString
												put: (Dictionary new
														at: #value put: grade;
														yourself) 
										]
										].
								dic ])).
	format := {self subjectGrade id.
			self id}.
	path := '/services/journal/examination/{1}/subjects/{2}/marks' format: format.
	self client
		path: path;
		entity: preparedEntity;
		post.
	^ self client response