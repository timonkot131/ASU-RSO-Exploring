views
gtPerfomance: aView context: aContext
	<gtView>
	aContext at: #gtTreeExpansionLevel ifAbsentPut: [ true ].
	^ aView forward
		title: 'Успеваемость';
		object: [ | quality absolute attOnly totals fives threes fours nas |
			totals := self totals collect: [:each | each final].
			attOnly := totals select: [:each | each isNumber].
			absolute := (attOnly size / totals size) asFloat.
			quality := ((attOnly select: [ :each | each > 3 ]) size / totals size)
					asFloat.
			fives := totals count: [ :each | each = 5 ].
			fours := totals count: [ :each | each = 4 ].
			threes := totals count: [ :each | each = 3 ].
			nas := totals count: [ :each | each = '.' ].
			Dictionary new
				at: 'Абсолютная успеваемость' put: absolute;
				at: 'Качественная успеваемость' put: quality;
				at: 'Оценки' put: (Dictionary new 
				at: '5-ки' put: fives;
				at: '4-ки' put: fours;
				at: '3-ки' put: threes;
				at: 'н-ки' put: nas; yourself);
				yourself ];
		view: #gtTreeFor: