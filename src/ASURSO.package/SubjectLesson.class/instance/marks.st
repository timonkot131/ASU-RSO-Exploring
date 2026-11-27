as yet unclassified
marks
	| students thisTasks |
	students := self students groupedBy: #id.
	thisTasks := self tasks groupedBy: #id.
	^ self markSets associations
		select: [ :kv | kv value includesKey: #marks ]
		thenFlatCollect: [ :pair | 
			| marks |
			marks := (pair value at: #marks) associations.
			marks collect: [ :each |
			GradeExecution new 
				student: (students at: pair key asInteger) first ;
				task: (thisTasks at: each key asInteger) first;
				grade: (each value at: #value ifAbsent: [nil])
				] ] 
			