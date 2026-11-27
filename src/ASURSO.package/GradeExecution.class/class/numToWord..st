utility
numToWord: anInteger
	^{
		1 -> 'One'.
		2 -> 'Two'.
		3 -> 'Three'.
		4 -> 'Four'.
		5 -> 'Five'.
		'' -> 'Five'.
	} asDictionary at: anInteger
