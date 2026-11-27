views
gtTeacherFor: aView
	<gtView>
	^ aView forward
		title: 'Преподаватель';
		object: [ self subjectTable ];
		view: #gtTeacherFor: