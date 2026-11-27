accessing
printOn: aStream
	^ aStream
		<< ('Название: {1}, ID: {2}'
				format: {name.
						id})