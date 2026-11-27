as yet unclassified
baseline: spec
	<baseline>
		^ spec for: #common do: [
			spec baseline: 'NeoJSON' with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
			spec package: 'ASURSO' with: [spec requires: #('NeoJSON')] .
			spec package: 'ASURSO Obsidian' with: [spec requires: #('ASURSO')].
			spec
					group: 'Core' with: #(#'ASURSO');
					group: 'Thin' with: #(#'ASURSO Obsidian').
		]