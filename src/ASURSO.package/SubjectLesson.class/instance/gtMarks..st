views
gtMarks: aView
	<gtView>
	^ aView columnedList
		title: 'Оценки';
		items: [ self marks ];
		column: 'Имя' text: #student;
		column: 'Оценка' text: [ :each |
		
			{'Five' -> 5.
			 'Four' -> 4.
			 'Three' -> 3.
			 'Two' -> 2.
			 nil -> 'Не выставлено'	 
			} asDictionary at: each grade
		
		].