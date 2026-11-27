as yet unclassified
textElement
	^ BlTextElement new
		text: self switchAttendanceType asRopedText;
		constraintsDo: [ :c | 
			c frame vertical alignCenter.
			c frame horizontal alignCenter ]