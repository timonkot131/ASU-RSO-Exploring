views
gtPairsFor: aView
	<gtView>
	^ aView forward
		title: 'Пары';
		priority: 10;
		object: [ self subjectTable ];
		actionUpdateButton;
		view: #gtLessonsFor: 