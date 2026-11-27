views
gtView2For: aView
	<gtView>
	^ aView forward
		title: 'Наполнение';
		object: [ self subjectTable ];
		view: #gtWorkingProgramFor: