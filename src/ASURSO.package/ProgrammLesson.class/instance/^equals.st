as yet unclassified
= anObject
^((anObject isKindOf: ProgrammLesson) or: [ anObject isKindOf: SubjectLesson]) ifTrue: [ self name = anObject name ]