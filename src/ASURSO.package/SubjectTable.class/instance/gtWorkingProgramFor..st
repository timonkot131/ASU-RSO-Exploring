views
gtWorkingProgramFor: aView
	<gtView>
	^ aView forward
		title: 'WorkingProgram наполнение';
		object: [ workingProgram ];
		view: #gtProgrammTree:context: