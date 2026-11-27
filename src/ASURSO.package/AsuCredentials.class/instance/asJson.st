accessing
asJson
	^ String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				prettyPrint: true;
				mapInstVarsFor: self class;
				nextPut: self ]