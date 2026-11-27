as yet unclassified
printOn: aStream
	student printOn: aStream.
	aStream << (' | ' , (self grade ifNotNil: [self grade asString] ifNil: [ absenceType reason ifNil: ['Present'] ]) ). 