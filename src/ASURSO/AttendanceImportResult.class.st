Class {
	#name : #AttendanceImportResult,
	#superclass : #Object,
	#instVars : [
		'result',
		'terminateBlock'
	],
	#category : #'ASURSO-Reports'
}

{ #category : #'as yet unclassified' }
AttendanceImportResult >> gtResultTree: aView [
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
	
]

{ #category : #accessing }
AttendanceImportResult >> result [
	^ result
]

{ #category : #accessing }
AttendanceImportResult >> result: anObject [
	result := anObject
]

{ #category : #accessing }
AttendanceImportResult >> terminateBlock [
	^ terminateBlock
]

{ #category : #accessing }
AttendanceImportResult >> terminateBlock: anObject [
	terminateBlock := anObject
]
