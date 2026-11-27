as yet unclassified
= anObject
(anObject isKindOf: self class) ifTrue: [
	^((self name = anObject name) and: self group = anObject group)
	 	and: self activity = anObject activity.
].
^false 