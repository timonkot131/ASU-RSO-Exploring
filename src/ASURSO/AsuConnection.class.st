Class {
	#name : #AsuConnection,
	#superclass : #Object,
	#instVars : [
		'credentials',
		'data',
		'client',
		'tasks'
	],
	#category : #'ASURSO-Model'
}

{ #category : #'as yet unclassified' }
AsuConnection class >> cultureCookie [
	^ ZnCookie new
		name: '.AspNetCore.Culture';
		value: 'c=ru|uic=ru';
		domain: self host;
		path: '/'
]

{ #category : #'as yet unclassified' }
AsuConnection class >> host [
	^ 'spo.asurso.ru'
]

{ #category : #accessing }
AsuConnection class >> withCredentials: anAsuCredentials [
	| client | 
	client := ZnClient new https
				host: self host.
	client session cookieJar add: self cultureCookie.
	^self new
		credentials: anAsuCredentials;
		client: client
]

{ #category : #'as yet unclassified' }
AsuConnection >> client [
^client
]

{ #category : #accessing }
AsuConnection >> client: anObject [
	client := anObject 
]

{ #category : #connection }
AsuConnection >> connect [
	client 
		path: '/services/security/login';
		entity: (ZnEntity json: credentials asJson).
	client post.
]

{ #category : #accessing }
AsuConnection >> credentials: anObject [ 
	credentials := anObject
]

{ #category : #accessing }
AsuConnection >> data: response [ 
	data := response
]

{ #category : #accessing }
AsuConnection >> groups [
	|items|
	client
		path: '/services/journal/gradebook/student-groups'.
	items := client withStreaming: [ | znStream |
			znStream := ZnCharacterReadStream on: client get.
			(NeoJSONReader on: znStream)
				mapInstVarsFor: StudentGroup;
				nextListAs: StudentGroup].
	^items collect: [:x | x connection: self].
]

{ #category : #views }
AsuConnection >> gtClientFor: aView [
	<gtView>
	^ aView forward
		title: 'Client session cookieJar';
		object: [ client ];
		view: #gtSessionFor:
]

{ #category : #views }
AsuConnection >> gtSolutions: aView [
	<gtView>
	^ aView forward
		title: 'Решения для бизнеса';
		object: [ self workingProgramms: 'Программные решения для бизнеса' ];
		view: #gtLiveFor:
]

{ #category : #views }
AsuConnection >> gtView1For: aView [
	<gtView>
	^ aView forward
		title: '4 ИСП';
		priority: 11;
		object: [ self groups
				select: [ :x | (x name includesSubstring: 'ИСП') and: [ x yearNumber = 4 ] ] ];
		view: #gtItemsFor:
]

{ #category : #views }
AsuConnection >> gtViewFor: aView [
	<gtView>
	^ aView forward
		priority: 10;
		title: 'Группы';
		object: [ self groups ];
		view: #gtItemsFor:
]

{ #category : #accessing }
AsuConnection >> injectMapping: aSchemaType [
	^ [ :m | 
	m
		listOfElementSchema: aSchemaType;
		reader: [ :r | (r nextListAs: aSchemaType) collect: [ :c | c connection: self ] ] ]
]

{ #category : #accessing }
AsuConnection >> tasks [
	^ tasks
]

{ #category : #accessing }
AsuConnection >> tasks: aSubjectTask [
	tasks := aSubjectTask
]

{ #category : #'as yet unclassified' }
AsuConnection >> workingProgramms: aString [
	| response array |
	response := client
			path: '/services/plan/working-programs';
			queryAt: #programName put: aString;
			queryAt: #orderBy put: '+name';
			get.
	array := (STONJSON fromString: response) at: #workingPrograms.
	^ array asAsyncStream
		collect: [ :each | 
			| res |
			res := client
					path: ('/services/plan/working-programs/{id}/thematic-plan' format: each);
					get.
			((NeoJSONReader on: res readStream)
					mapInstVarsFor: ThematicPlan;
					nextAs: ThematicPlan)
				connection: self;
				asWorkingProgramm ]
]
