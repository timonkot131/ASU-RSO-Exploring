views
gtProgrammTree: aView context: aContext
	<gtView>
	^ aView columnedTree
		expandUpTo: 1;
		title: 'Наполнение';
		items: [ self topics  ];
		contextItemLabel: 'Скопировать' action: [ :element :item |
		"	Clipboard clipboardText: item asString."
		];
		children: [ :each | each children  ]