Extension { #name : 'ZnClient' }

{ #category : '*asurso' }
ZnClient >> withStreaming: aBlock [
	| result |
	self streaming: true.
	result := aBlock value.
	self streaming: false.
	^ result
]
