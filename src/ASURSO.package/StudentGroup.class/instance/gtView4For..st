views
gtView4For: aView
	<gtView>
	^ aView forward
		title: 'Студенты';
		object: [ self activeJournal scheduleSubjects first ];
		view: #gtViewFor: