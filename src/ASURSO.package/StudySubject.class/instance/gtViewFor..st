views
gtViewFor: aView
	<gtView>
	^ aView forward
		title: 'Студенты';
		priority: 20;
		object: [ self subjectTable ];
		view: #gtStudentsFor: