as yet unclassified
= anObject
(anObject isKindOf: self class) ifFalse: [^false].
^ self name = anObject name