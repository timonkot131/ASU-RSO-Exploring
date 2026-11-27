views
gtViewProgFor: aView
	<gtView>
	^ aView forward
		priority: 7;
		title: 'Разработка программных модулей';
		object: [ self activeJournal scheduleSubjects
				detect: [ :x | x name includesSubstring: 'Разработка программных модулей' ] ];
		view: #gtPairsFor: