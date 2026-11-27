views
gtViewFor: aView
	<gtView>
	^ aView forward
		priority: 10;
		title: 'Группы';
		object: [ self groups ];
		view: #gtItemsFor: