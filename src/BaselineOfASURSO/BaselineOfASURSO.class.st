Class {
	#name : #BaselineOfASURSO,
	#superclass : #BaselineOf,
	#category : #BaselineOfASURSO
}

{ #category : #'as yet unclassified' }
BaselineOfASURSO >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'ASURSO'
		]
]

{ #category : #'as yet unclassified' }
BaselineOfASURSO >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'ASURSO' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]
