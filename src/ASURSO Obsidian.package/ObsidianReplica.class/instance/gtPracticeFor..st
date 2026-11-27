views
gtPracticeFor: aView
	<gtView>
	^ aView forward
		title: 'Практика';
		priority: 10;
		object: [ 
			(self journal: self practice) title: 'Практические'.
			];
		view: #gtViewFor: