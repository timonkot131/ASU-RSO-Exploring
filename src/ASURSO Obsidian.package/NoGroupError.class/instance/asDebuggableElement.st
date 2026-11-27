as yet unclassified
asDebuggableElement
	^ PhlowDebuggableElementStencil new
		freeze: self; 
		object: self object;
		view: self view;
		asElement. 