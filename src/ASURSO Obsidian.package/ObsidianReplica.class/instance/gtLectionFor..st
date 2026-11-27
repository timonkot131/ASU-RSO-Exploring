views
gtLectionFor: aView
	<gtView>
	^ aView forward
		title: 'Лекции';
		priority: 20;
		object: [ self journal: self lection ];
		view: #gtViewFor: