accessing
absent
	^(self markSets associations select: [:kv | kv value includesKey: #absenceType]
		thenCollect: [ :kv | 
			(self students detect: [ :student | student id = kv key asInteger ])
				-> (kv value at: 'absenceType') ]) asDictionary