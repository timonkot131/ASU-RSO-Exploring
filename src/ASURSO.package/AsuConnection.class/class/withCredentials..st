accessing
withCredentials: anAsuCredentials
	| client | 
	client := ZnClient new https
				host: self host.
				"autoResetEntityMethods: #(GET DELETE HEAD)."
				
	client session cookieJar add: self cultureCookie.
	
	^self new
		credentials: anAsuCredentials;
		client: client