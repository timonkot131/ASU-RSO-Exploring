as yet unclassified
absenceType: aString
self data at: #'Тип отсутствия' put: (ObsidianReplica asObsidianReference:  aString).
self announce: ObsidianAttendanceUpdate.