views
gtDataFor: aView
	<gtView>
	data ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Data';
		items: [ data ];
		column: 'Value' text: [ :each | each gtDisplayString ]