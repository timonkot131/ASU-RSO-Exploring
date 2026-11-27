accessing
topics
	| indexed |
	indexed := self sections
			collectWithIndex: [ :section :i | 
				(section at: #topics)
					collectWithIndex: [ :topic :j | 
						| lessons |
						lessons := (topic at: #lessons)
								collect: [ :lesson | 
									ProgrammLesson new
										connection: self connection;
										duration: (lesson at: #duration);
										id: (lesson at: #id);
										name: (lesson at: #name) ].
						ProgrammTopic new
							index: j;
							sectionIndex: i;
							name: (topic at: #name);
							lessons: lessons ] ].
	^ indexed flatten