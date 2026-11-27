accessing
taskString
	^ ', ' join: (self tasks collect: [:task | task name])