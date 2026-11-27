as yet unclassified
asElement
	^ BlElement new
		in: [ :anElement | anElement userData at: #data put: self ];
		border: (BlBorder paint: Color black width: 1);
		layout: BlFrameLayout new;
		addChild: self textElement;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		when: BlClickEvent do: [ self nextAbsence ];
		in: [ :anElement | 
			self
				when: ObsidianAttendanceUpdate
				do: [ anElement removeChildren.
					anElement addChild: self textElement ] ];
		yourself