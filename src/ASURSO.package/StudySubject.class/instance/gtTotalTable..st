views
gtTotalTable: aView
	<gtView>
	^ aView columnedList
		title: 'Итоговые оценки';
		items: [ self totals ];
		actionButtonLabel: 'Обновить оценки!'
			action: [ :element | self bindTotalGrades: self totals.
				element phlow fireViewUpdateWish ];
		column: 'Студент' text: #fullName;
		column: 'Средняя оценка' text: #average;
		column: 'Итоговая оценка' text: #final.