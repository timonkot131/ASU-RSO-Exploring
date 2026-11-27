helpers
attendanceSwitch: aString
^{
	'Заболел' -> AsuAbsenceReason sickLeave.
	'Отсутствует' -> AsuAbsenceReason noValidReason.
	'Заявление' -> AsuAbsenceReason validReason.
	'Опоздал' -> AsuAbsenceReason isLate 
} asDictionary at: aString.