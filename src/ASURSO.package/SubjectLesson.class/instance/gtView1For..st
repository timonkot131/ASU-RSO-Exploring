views
gtView1For: aView
	<gtView>
	^ aView forward
		title: 'Нки';
		object: [ self absent select: [ :x | x = AsuAbsenceReason noValidReason reason ] ];
		view: #gtKeysFor: