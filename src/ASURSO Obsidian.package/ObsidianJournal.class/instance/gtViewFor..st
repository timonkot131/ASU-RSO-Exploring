views
gtViewFor: aView
	<gtView>
	^ aView forward
		title: 'Live';
		object: [ self element ];
		actionButtonIcon: BrGlamorousVectorIcons savetodisk 
			 action: [self replica export: (((self items | self sourced) select: [:each | each isForExport] thenCollect: [:each | each data]) ) source: self source];
		view: #gtLiveFor: