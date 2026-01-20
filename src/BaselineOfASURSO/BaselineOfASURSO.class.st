Class {
	#name : 'BaselineOfASURSO',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfASURSO',
	#package : 'BaselineOfASURSO'
}

{ #category : 'as yet unclassified' }
BaselineOfASURSO >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
			spec package: 'ASURSO'.
		]
]

{ #category : 'as yet unclassified' }
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
