exporting
export: aDictionaryArray source: aSource
aSource deleteAllChildren.
aDictionaryArray do: [ :each | 
	| hash aFile |
	hash := each hash asString.
	aFile := aSource / hash, 'md' .
	aFile writeStreamDo: [:s | 
		s nextPutAll: '---'; cr.
		each keysAndValuesDo: [ :key :value | 
			s nextPutAll: key;
			nextPutAll: ': ';
			nextPutAll: value;
			cr.
		].
		s nextPutAll: '---'.
	]
]