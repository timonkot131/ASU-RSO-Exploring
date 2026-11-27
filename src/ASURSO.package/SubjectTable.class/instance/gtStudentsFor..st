views
gtStudentsFor: aView
	<gtView>
	^ aView forward
		title: 'Студенты';
		object: [ students ];
		view: #gtItemsFor: