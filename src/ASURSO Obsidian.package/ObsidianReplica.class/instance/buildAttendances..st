accessing
buildAttendances: source
	^ self group files
		flatCollect: [ :student | 
			source files
				collect: [ :aLection | 
					ObsidianAttendance new
						data: (Dictionary new
								at: #'Имя' put: (ObsidianReplica asObsidianReference: student base);
								at: #'Занятие' put: (ObsidianReplica asObsidianReference: aLection base);
								at: #'Группа'
									put: (ObsidianReplica asObsidianReference: self group base);
								at: #'Тип отсутствия' put: '';
								yourself) ] ]