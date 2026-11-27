as yet unclassified
printOn: aStream 
aStream << self name.
self date ifNotNil: [ 
aStream << (' ', self dateString)
]