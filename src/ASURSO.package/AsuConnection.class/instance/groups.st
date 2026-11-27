accessing
groups
	|items|
	client
		path: '/services/journal/gradebook/student-groups'.
	items := client withStreaming: [ | znStream |
			znStream := ZnCharacterReadStream on: client get.
			(NeoJSONReader on: znStream)
				mapInstVarsFor: StudentGroup;
				nextListAs: StudentGroup].
	^items collect: [:x | x connection: self].