views
gtScheduleSubjectsFor: aView
	<gtView>
	scheduleSubjects ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Журналы';
		items: [ scheduleSubjects ];
		column: 'Value' text: [ :each | each gtDisplayString ]