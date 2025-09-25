Class {
	#name : #BlSvgSAXParserExamples,
	#superclass : #Object,
	#category : #'BlocPac-Geometry-SVG'
}

{ #category : #accessing }
BlSvgSAXParserExamples >> importSvg [
	<gtExample>
	| parser resultElement |
	parser := BlSvgSAXParser
			parse: '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns:xl="http://www.w3.org/1999/xlink" version="1.1" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" width="16" height="16">
  <defs/>
  <g id="over_1" fill-opacity="1" stroke="none" stroke-opacity="1" stroke-dasharray="none" fill="none">
    <title>over 1</title>
    <g id="over_1_Layer_1">
      <title>Layer 1</title>
      <g id="Graphic_12">
        <path d="M 5 3 L 11 7 L 5 11 Z" stroke="black" stroke-linecap="round" stroke-linejoin="miter" stroke-width="2"/>
      </g>
      <g id="Graphic_14">
        <rect x="7" y="12" width="6" height="2" fill="black"/>
      </g>
    </g>
  </g>
</svg>
'.
	resultElement := parser resultElement.
	self assert: (resultElement isKindOf: BlElement).
	self assert: resultElement children size equals: 2.
	^ parser
]
