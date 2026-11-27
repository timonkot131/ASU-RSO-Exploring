views
gtView3For: aView
	<gtView>
	^ aView forward
		priority: 7;
		title: 'Компьютерные сети';
		object: [ self activeJournal scheduleSubjects
				detect: [ :x | x name includesSubstring: 'Компьютерные сети' ] ];
		view: #gtPairsFor: