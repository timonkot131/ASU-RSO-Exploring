views
gtAttendanceView: aView context: aContext
	<gtView>
		aContext at: #gtTreeExpansionLevel ifAbsentPut: [ true ].
	^ aView forward 
		priority: 6;
		title: 'Новые посещения';
		object: [  self attendanceExecutions ];
		view: #gtTreeFor:context:; 
		actionButtonLabel: 'Импортировать'
			action: [ :element | 
				element phlow spawnObject: (self importAttendence: self attendanceExecutions). ].