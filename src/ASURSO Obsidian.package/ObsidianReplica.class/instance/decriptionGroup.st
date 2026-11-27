magritte
decriptionGroup
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #group;
		label: 'Группа';
		priority: 41;
		options: self groupSource gtChildren ;
		default: self groupSource gtChildren first; "To avoid storing unneeded empty set [1]"
		reference: MAClassDescription new;
		yourself