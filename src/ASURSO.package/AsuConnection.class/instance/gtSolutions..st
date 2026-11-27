views
gtSolutions: aView
	<gtView>
	^ aView forward
		title: 'Решения для бизнеса';
		object: [ self workingProgramms: 'Программные решения для бизнеса' ];
		view: #gtLiveFor: