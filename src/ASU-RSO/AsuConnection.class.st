Class {
	#name : #AsuConnection,
	#superclass : #Object,
	#instVars : [
		'credentials',
		'data',
		'client'
	],
	#category : #'ASU-RSO-Model'
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
AsuConnection >> gtClient1For: aView [
	<gtView>
	^ aView forward
		title: 'Client hTTP';
		object: [ client ];
		view: #gtHttpFor:
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
