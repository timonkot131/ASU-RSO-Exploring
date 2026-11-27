views
gtViewFor: aView
	<gtView>
	^ aView forward
		title: 'Отсутствующие';
		object: [ self absent ];
		view: #gtItemsFor: