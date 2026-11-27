views
gtGradeView: aView context: aContext
	"	^self gradeExecutions gtTreeFor: aView context"
	<gtView>
	aContext at: #gtTreeExpansionLevel ifAbsentPut: [ true ].
	^ aView forward
		priority: 5; 
		title: 'Новые оценки';
		object: [ self gradeExecutions ];
		view: #gtTreeFor:context:; 
		actionButtonLabel: 'Импортировать'
			action: [ :element | 
				element phlow spawnObject: (self importGrades: self gradeExecutions). ].