magritte
decriptionPractice
	<magritteDescription>
	^ MASingleOptionDescription new
		accessor: #practice;
		label: 'Практика';
		priority: 40;
		options: self practicalSources;
		default: self practicalSources first; "To avoid storing unneeded empty set [1]"
		reference: MAClassDescription new;
		yourself