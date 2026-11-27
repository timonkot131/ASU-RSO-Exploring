views
gtViewFor: aView
	<gtView>
	^ aView forward
		title: 'Live';
		object: [ self asElement ];
		view: #gtLiveFor: