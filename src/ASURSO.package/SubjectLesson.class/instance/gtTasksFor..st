views
gtTasksFor: aView
	<gtView>
	^ aView forward
		title: 'Задания';
		object: [ self tasks ];
		view: #gtItemsFor: