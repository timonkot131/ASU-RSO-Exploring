Class {
	#name : #StudySubject,
	#superclass : #Object,
	#instVars : [
		'connection',
		'plannedHours',
		'id',
		'name',
		'remarks',
		'isAttendanceEditable',
		'subjectGrade'
	],
	#category : #'ASU-RSO-Model'
}

{ #category : #'as yet unclassified' }
StudySubject >> = anObject [
^(anObject isKindOf: StudySubject) ifTrue:
 [self name = anObject name]
]

{ #category : #'as yet unclassified' }
StudySubject >> absentEntityOf: anAsuAbsenceReason [ 
^ Dictionary new
	at: #absenceReason put: nil;
	at: #absenceType put: anAsuAbsenceReason reason;
	at: #marks put: Dictionary new;
	yourself.
	
]

{ #category : #'as yet unclassified' }
StudySubject >> client [ 
^ connection client
]

{ #category : #accessing }
StudySubject >> connection [
	^ connection
]

{ #category : #accessing }
StudySubject >> connection: anObject [
	connection := anObject
]

{ #category : #views }
StudySubject >> gtView1For: aView [
	<gtView>
	^ aView forward
		title: 'Пары';
		priority: 10;
		object: [ self subjectTable ];
		view: #gtLessonsFor:
]

{ #category : #views }
StudySubject >> gtViewFor: aView [
	<gtView>
	^ aView forward
		title: 'Студенты';
		priority: 20;
		object: [ self subjectTable ];
		view: #gtStudentsFor:
]

{ #category : #comparing }
StudySubject >> hash [
	^ self name hash hashMultiply
]

{ #category : #accessing }
StudySubject >> id [
	^ id
]

{ #category : #accessing }
StudySubject >> id: anObject [
	id := anObject
]

{ #category : #accessing }
StudySubject >> name [
	^ name
]

{ #category : #accessing }
StudySubject >> name: anObject [
	name := anObject
]

{ #category : #'as yet unclassified' }
StudySubject >> printOn: aStream [
aStream << name
]

{ #category : #'as yet unclassified' }
StudySubject >> setAbsenceLesson: aSubjectLesson student: aSubjectUser type: anAsuAbsenceReason [
	| format path |
	format := {self subjectGrade id.
			self id.
			aSubjectLesson id.
			aSubjectUser id}.
	path := '/services/journal/gradebook/{1}/subjects/{2}/lessons/{3}/students/{4}'
			format: format.
	self client path: path ;
		entity: (ZnEntity json: (STONJSON toString: (self absentEntityOf: anAsuAbsenceReason )));
		put.
	^self client response
]

{ #category : #accessing }
StudySubject >> subjectGrade [
	^ subjectGrade
]

{ #category : #accessing }
StudySubject >> subjectGrade: anObject [
	subjectGrade := anObject
]

{ #category : #'as yet unclassified' }
StudySubject >> subjectTable [
	| result |
	self client path: ('/services/journal/gradebook/{1}/subjects/{2}' format: {self subjectGrade id. self id}).
	result := self client withStreaming: [ | znStream |
			znStream := ZnCharacterReadStream on: self client get.
			(NeoJSONReader on: znStream)
				mapAllInstVarsFor: SubjectLesson;
				mapAllInstVarsFor: SubjectStudent;
				for: SubjectTable do: [:table | 
						(table mapInstVar: 'lessons') valueSchema: #Lessons.
						(table mapInstVar: 'students') valueSchema: #Students
					];
				for: #Lessons customDo: [ :mapping | 
					mapping listOfElementSchema: SubjectLesson];
				for: #Students customDo: [ :mapping | 
					mapping listOfElementSchema: SubjectStudent
				];
				nextAs: SubjectTable].
	result lessons do: [:x | x subjectTable: result].
	result studySubject: self.
	^result connection: self connection.
]
