Extension { #name : 'OrderedDictionary' }

{ #category : '*ASURSO' }
OrderedDictionary >> lookupThree: aView [
	<gtView>
	^ aView columnedTree
		title: 'Items3';
		items: [ self associations ];
		children: [ :each | 
			each value isDictionary
				ifTrue: [ each value associations ]
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];
		column: 'Key' text: #key;
		column: 'Value' text: #value weight: 3;
		contextItemLabel: 'Inspect key' action: [ :anElement :assoc | anElement phlow spawnObject: assoc value key ];
			contextItemLabel: 'Тройбаны' action: [ :anElement :assoc | anElement phlow spawnObject: (assoc value collect: [:x | x subject forLesson: x lesson task: x task grades: {x} | ({x lesson} & x lessons) first marks  ]  ) ];
		contextItemLabel: 'Inspect association' action: [ :anElement :assoc | anElement phlow spawnObject: assoc value ];
		send: #value
]
