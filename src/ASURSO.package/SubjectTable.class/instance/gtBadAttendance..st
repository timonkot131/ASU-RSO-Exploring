views
gtBadAttendance: aView
	<gtView>
	^ aView forward
		title: 'Прогульщики';
		object: [ (self students
				collect: [ :student | 
					student
						-> (self lessons
								count: [ :lesson | 
									lesson absent
										at: student
										ifPresent: [ :value | value = AsuAbsenceReason noValidReason reason ]
										ifAbsent: [ false ] ]) ]) sort: #value descending ];
		view: #gtItemsFor: