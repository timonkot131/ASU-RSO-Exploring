magritte
decriptionLection
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #lection;
		label: 'Лекции';
		priority: 41;
		options: self lectionSources;
		default: self lectionSources first; "To avoid storing unneeded empty set [1]"
		reference: MAClassDescription new;
		yourself