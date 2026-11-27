views
gtPathFor: aView
	<gtView>
	^ aView forward
		title: 'Path';
		object: [ self file asFileReference ];
		view: #gtPathFor: