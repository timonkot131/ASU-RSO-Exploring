accessing
injectMapping: aSchemaType
	^ [ :m | 
	m
		listOfElementSchema: aSchemaType;
		reader: [ :r | (r nextListAs: aSchemaType) collect: [ :c | c connection: self ] ] ]