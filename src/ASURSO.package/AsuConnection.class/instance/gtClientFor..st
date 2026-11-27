views
gtClientFor: aView
	<gtView>
	^ aView forward
		title: 'Client session cookieJar';
		object: [ client ];
		view: #gtSessionFor: