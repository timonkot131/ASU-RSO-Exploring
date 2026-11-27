views
gtIsp3View: aView
	<gtView>
	^ aView forward
		title: '3 ИСП';
		priority: 11;
		object: [ self groups
				select: [ :x | (x name includesSubstring: 'ИСП') and: [ x yearNumber = 3 ] ]];
		view: #gtItemsFor: