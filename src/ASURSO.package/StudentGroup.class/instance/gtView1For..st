views
gtView1For: aView
	<gtView>
	^ aView forward
		title: 'Текущий журнал';
		priority: 10;
		object: [ self journal detect: #isActive ];
		view: #gtScheduleSubjectsFor: