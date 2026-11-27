as yet unclassified
gtResultTree: aView
	<gtView>
	| stream |
	stream := self result.
	^aView columnedList
		items: [stream asyncSimilarCopy ];
		title: 'Результаты';
		actionButtonLabel: 'Прекратить выполнение'
		action: [ :element | self terminateBlock value.  ];
		column: 'Статус' icon: [:each | 
			each isOk ifTrue: [BrGlamorousIcons greencircle] ifFalse: [BrGlamorousIcons redcircle]
		];
		column: 'Группа' text: #group;
		column: 'Дата' text: [:each | each lesson dateString];
		column: 'Пара' text: #lesson;
		column: 'Дисциплина' text: #subject.
	