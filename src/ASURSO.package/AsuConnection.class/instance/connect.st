connection
connect
	client 
		path: '/services/security/login';
		entity: (ZnEntity json: credentials asJson).
	client post.