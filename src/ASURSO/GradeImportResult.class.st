Class {
	#name : #GradeImportResult,
	#superclass : #Object,
	#instVars : [
		'result',
		'terminateBlock'
	],
	#category : #'ASURSO-Reports'
}

{ #category : #'as yet unclassified' }
GradeImportResult >> gtResultTree: aView [
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
GradeImportResult >> result [
	^ result
]

{ #category : #accessing }
GradeImportResult >> result: anObject [
	result := anObject
]

{ #category : #accessing }
GradeImportResult >> terminateBlock [
	^ terminateBlock
]

{ #category : #accessing }
GradeImportResult >> terminateBlock: anObject [
	terminateBlock := anObject
]
