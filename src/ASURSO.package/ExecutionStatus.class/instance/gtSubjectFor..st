views
gtSubjectFor: aView
	<gtView>
	^ aView forward
		title: 'Subject пары';
		object: [ subject ];
		view: #gtPairsFor: