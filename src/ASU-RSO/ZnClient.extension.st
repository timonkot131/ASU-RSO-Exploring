Extension { #name : #ZnClient }

{ #category : #'*ASU-RSO*' }
ZnClient >> withStreaming: aBlock [
	| result |
	self streaming: true.
	result := aBlock value.
	self streaming: false.
	^ result
]
