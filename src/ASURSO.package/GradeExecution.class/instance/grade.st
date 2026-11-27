accessing
grade
	^grade ifNil: [
		task ifNotNil: [:item | 
				item isRequired ifTrue: [ 
					GradeExecution numToWord: 2
				] 
				ifFalse: [ nil ]
			]
	]