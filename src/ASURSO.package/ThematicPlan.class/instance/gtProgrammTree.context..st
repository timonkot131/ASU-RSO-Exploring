as yet unclassified
gtProgrammTree: aView context: aContext
	<gtView>
	^ aView columnedTree
		expandUpTo: 1;
		title: 'Наполнение';
		items: [ self topics ];
		children: [ :each | each children ]