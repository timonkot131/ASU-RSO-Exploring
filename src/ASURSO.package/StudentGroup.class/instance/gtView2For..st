views
gtView2For: aView
	<gtView>
	^ aView forward
		priority: 5;
		
		title: 'Решения для бизнеса';
		object: [ self activeJournal scheduleSubjects
				detect: [ :x | (x name includesSubstring: 'решения для бизнеса') or: [x name includesSubstring: 'Основы разработки мобильных приложений'] ] ];
		view: #gtPairsFor: