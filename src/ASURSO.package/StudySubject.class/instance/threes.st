accessing
threes
	| res table |
	table := self subjectTable.
	table lessons select: [ :task | task tasks size isZero not ].
	res := table students
			flatCollect: [ :s | 
				| exs |
				exs := table lessons
						select: [ :task | task tasks size isZero not ]
						thenCollect: [ :l | 
							l marks
								detect: [ :m | m student = s ]
								ifFound: [ :v | 
									v copy
										lesson: l;
										subject: self ]
								ifNone: [ nil ] ].
				exs
					select: [ :v | v isNotNil and: [ v grade isNil ] ]
					thenCollect: [ :v | v copy grade: 'Three' ] ].
	^ res groupedBy: [:each | each student]