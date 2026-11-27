accessing
_
	^ ZnClient new
		url: 'https://spo.asurso.ru/services/security/login';
		entity: (ZnEntity json: self asJson);
		post