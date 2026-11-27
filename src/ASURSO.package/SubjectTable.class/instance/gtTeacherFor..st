views
gtTeacherFor: aView
	<gtView>
	^ aView forward
		title: 'Преподаватель';
		object: [ teacher ];
		view: #gtStringFor: