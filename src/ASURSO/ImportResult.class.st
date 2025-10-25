Class {
	#name : #ImportResult,
	#superclass : #Object,
	#instVars : [
		'result',
		'terminateBlock'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
ImportResult >> gtResultTree: aView [
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
		column: 'Задание' text: #task;
		column: 'Группа' text: #group;
		column: 'Пара' text: #lesson;
		column: 'Дисциплина' text: #subject.
	
]

{ #category : #accessing }
ImportResult >> result [
	^ result
]

{ #category : #accessing }
ImportResult >> result: anObject [
	result := anObject
]

{ #category : #accessing }
ImportResult >> terminateBlock [
	^ terminateBlock
]

{ #category : #accessing }
ImportResult >> terminateBlock: anObject [
	terminateBlock := anObject
]
