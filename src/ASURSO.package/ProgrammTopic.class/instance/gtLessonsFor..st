views
gtLessonsFor: aView
	<gtView>
	lessons ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Lessons';
		items: [ lessons ];
		column: 'Value' text: [ :each | each gtDisplayString ]