views
clearAllTasks
	self lessons do: [ :each | self studySubject removeTaskForLesson: each ]