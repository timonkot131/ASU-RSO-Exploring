Extension { #name : #ZnClient }

{ #category : #'*ASURSO*' }
ZnClient >> withStreaming: aBlock [
	| result |
	self streaming: true.
	result := aBlock value.
	self streaming: false.
	^ result
]
