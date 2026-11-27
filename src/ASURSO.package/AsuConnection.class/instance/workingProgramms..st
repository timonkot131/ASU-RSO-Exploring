as yet unclassified
workingProgramms: aString
	| response array |
	response := client
			path: '/services/plan/working-programs';
			queryAt: #programName put: aString;
			queryAt: #orderBy put: '+name';
			get.
	array := (STONJSON fromString: response) at: #workingPrograms.
	^ array asAsyncStream
		collect: [ :each | 
			| res |
			res := client
					path: ('/services/plan/working-programs/{id}/thematic-plan' format: each);
					get.
			((NeoJSONReader on: res readStream)
					mapInstVarsFor: ThematicPlan;
					nextAs: ThematicPlan)
				connection: self;
				asWorkingProgramm ]