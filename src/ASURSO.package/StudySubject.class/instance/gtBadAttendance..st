views
gtBadAttendance: aView
	<gtView>
	^ aView forward
		title: 'Прогульщики';
		object: [ self subjectTable ];
		view: #gtBadAttendance: