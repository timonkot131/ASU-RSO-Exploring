views
gtView1For: aView
	<gtView>
	^ aView forward
		title: '4 ИСП';
		priority: 11;
		object: [ self groups
				select: [ :x | (x name includesSubstring: 'ИСП') and: [ x yearNumber = 4 ] ]];
		view: #gtItemsFor: