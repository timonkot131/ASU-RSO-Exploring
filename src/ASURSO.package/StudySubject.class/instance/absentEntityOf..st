utilities
absentEntityOf: anAsuAbsenceReason 
^ Dictionary new
	at: #absenceReason put: nil;
	at: #absenceType put: anAsuAbsenceReason reason;
	at: #marks put: Dictionary new;
	yourself.
	