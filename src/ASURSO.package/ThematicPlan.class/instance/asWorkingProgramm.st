accessing
asWorkingProgramm
	^ WorkingProgramm new
		connection: self connection;
		name: self name;
		topics: self topics