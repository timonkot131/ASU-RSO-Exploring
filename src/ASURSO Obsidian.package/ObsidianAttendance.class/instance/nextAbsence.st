as yet unclassified
nextAbsence
self data at: #'Тип отсутствия' update: [:anItem |
	ObsidianReplica asObsidianReference: (
	{
	'' -> 'Отсутствует'.
	'Отсутствует' -> 'Опоздал'	.
	'Опоздал' -> 'Заболел'.
	'Заболел' ->'Заявление'.
	'Заявление' -> ''.
} asDictionary at: (ObsidianReplica fromObsidianReference: anItem))].
self announce: ObsidianAttendanceUpdate.