utilities
prepareBind: aSubjectLesson to: aProgrammLesson 
^Dictionary new 
		at: #date put: aSubjectLesson date;
		at: #duration put: aProgrammLesson duration;
		at: #type put: aProgrammLesson type;
		at: #scheduleLessonId put: aSubjectLesson scheduleLessonId;
		at: #plannedLessons put: (Dictionary new at: aProgrammLesson id asString 
			put: aProgrammLesson duration; yourself);
		yourself.
		