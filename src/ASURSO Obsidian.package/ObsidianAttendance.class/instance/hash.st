comparing
hash
	^ (self name hash hashMultiply bitXor: self group hash hashMultiply)
		bitXor: self activity hash hashMultiply