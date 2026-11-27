*asurso obsidian*
gtSubjectTable: anAction
<gtAction>
	^ anAction button
		priority: 76;
		icon: BrGlamorousVectorIcons note;
		tooltip: 'Открыть журнал предмета';
		id: GtInspectorInspectButtonId;
		action: [ :aButton |
			aButton phlow spawnObject: self subjectTable ];
		primaryModifierAction: [ :aButton |
				aButton phlow showObject: self subjectTable ]
			mouseCursor: BlCopyCursor new
