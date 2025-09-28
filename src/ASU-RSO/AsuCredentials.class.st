Class {
	#name : #AsuCredentials,
	#superclass : #Object,
	#instVars : [
		'isRemember',
		'password',
		'login'
	],
	#category : #'ASU-RSO-Model'
}

{ #category : #accessing }
AsuCredentials >> _ [
	^ ZnClient new
		url: 'https://spo.asurso.ru/services/security/login';
		entity: (ZnEntity json: self asJson);
		post
]

{ #category : #accessing }
AsuCredentials >> asJson [
	^ String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				prettyPrint: true;
				mapInstVarsFor: self class;
				nextPut: self ]
]

{ #category : #accessing }
AsuCredentials >> asuConnection [
	^(AsuConnection
		withCredentials: self) connect
]

{ #category : #accessing }
AsuCredentials >> isRemember [
	^ isRemember
]

{ #category : #accessing }
AsuCredentials >> isRemember: anObject [
	isRemember := anObject
]

{ #category : #accessing }
AsuCredentials >> login [
	^ login
]

{ #category : #accessing }
AsuCredentials >> login: anObject [
	login := anObject
]

{ #category : #accessing }
AsuCredentials >> password [
	^ password
]

{ #category : #accessing }
AsuCredentials >> password: anObject [
	password := anObject
]
