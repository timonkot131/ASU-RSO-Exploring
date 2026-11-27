views
gtViewFor: aView
	<gtView>
	^ aView forward
		title: 'Журнал';
		priority: 20;
		object: [ self journal ];
		view: #gtItemsFor: