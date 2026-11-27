as yet unclassified
cultureCookie
	^ ZnCookie new
		name: '.AspNetCore.Culture';
		value: 'c=ru|uic=ru';
		domain: self host;
		path: '/'