Class {
	#name : #BlSvgSAXParserExamples,
	#superclass : #Object,
	#category : #'BlocPac-Geometry-SVG'
}

{ #category : #accessing }
BlSvgSAXParserExamples >> importSvgWithCircle [
	<gtExample>
	| parser resultElement |
	parser := BlSvgSAXParser
			parse: '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xl="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" version="1.1" viewBox="0 0 16 16" width="16" height="16">
  <defs/>
  <g id="gray_flag" fill="none" stroke="none" stroke-opacity="1" stroke-dasharray="none" fill-opacity="1">
    <title>gray flag</title>
    <g id="gray_flag_Layer_1">
      <title>Layer 1</title>
      <g id="Graphic_299">
        <circle cx="8" cy="8" r="3.00000479370569" fill="black"/>
      </g>
    </g>
  </g>
</svg>'.
	resultElement := parser resultElement.
	self assert: (resultElement isKindOf: BlElement).
	self assert: resultElement children isEmpty.
	self assert: resultElement border width isZero.
	^ resultElement
]

{ #category : #accessing }
BlSvgSAXParserExamples >> importSvgWithPathAndRect [
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

{ #category : #accessing }
BlSvgSAXParserExamples >> importSvgWithPaths [
	<gtExample>
	| parser resultElement |
	parser := BlSvgSAXParser
			parse: '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns:xl="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 16 16" width="16" height="16">
  <defs/>
  <g id="minimize_arrows" fill-opacity="1" stroke="none" stroke-opacity="1" stroke-dasharray="none" fill="none">
    <title>minimize arrows</title>
    <g id="minimize_arrows_layer">
      <title>layer</title>
      <g id="Graphic_38">
        <path d="M 9.757359 5.535534 L 13.292893 2 L 14 2.7071068 L 10.464466 6.242641 Z" fill="black"/>
      </g>
      <g id="Graphic_37">
        <path d="M 10.464466 9.55736 L 14 13.092893 L 13.292893 13.8 L 9.757359 10.264466 Z" fill="black"/>
      </g>
      <g id="Graphic_36">
        <path d="M 6.242641 5.535534 L 2.7071068 2 L 2 2.7071068 L 5.535534 6.242641 Z" fill="black"/>
      </g>
      <g id="Graphic_35">
        <path d="M 5.535534 9.55736 L 2 13.092893 L 2.7071068 13.8 L 6.242641 10.264466 Z" fill="black"/>
      </g>
      <g id="Graphic_34">
        <path d="M 9.757359 5.535534 L 13.292893 2 L 14 2.7071068 L 10.464466 6.242641 Z" fill="black"/>
      </g>
      <g id="Graphic_33">
        <path d="M 10.464466 9.55736 L 14 13.092893 L 13.292893 13.8 L 9.757359 10.264466 Z" fill="black"/>
      </g>
      <g id="Graphic_54">
        <path d="M 9.757359 9.55736 L 9.757359 10.55736 L 9.757359 12.55736 L 10.757359 12.55736 L 10.757359 10.55736 L 12.75736 10.55736 L 12.75736 9.55736 L 10.757359 9.55736 Z" fill="black"/>
      </g>
      <g id="Graphic_29">
        <path d="M 5.535534 9.55736 L 2 13.092893 L 2.7071068 13.8 L 6.242641 10.264466 Z" fill="black"/>
      </g>
      <g id="Graphic_53">
        <path d="M 10.757359 6.242641 L 12.75736 6.242641 L 12.75736 5.242641 L 10.757359 5.242641 L 10.757359 3.2426407 L 9.757359 3.2426407 L 9.757359 5.242641 L 9.757359 6.242641 Z" fill="black"/>
      </g>
      <g id="Graphic_52">
        <path d="M 6.242641 6.242641 L 6.242641 5.242641 L 6.242641 3.2426407 L 5.2426407 3.2426407 L 5.2426407 5.242641 L 3.2426407 5.242641 L 3.2426407 6.242641 L 5.2426407 6.242641 Z" fill="black"/>
      </g>
      <g id="Graphic_55">
        <path d="M 5.2426407 10.55736 L 5.2426407 12.55736 L 6.242641 12.55736 L 6.242641 10.55736 L 6.242641 9.55736 L 5.2426407 9.55736 L 3.2426407 9.55736 L 3.2426407 10.55736 Z" fill="black"/>
      </g>
      <g id="Graphic_32">
        <path d="M 6.242641 5.535534 L 2.7071068 2 L 2 2.7071068 L 5.535534 6.242641 Z" fill="black"/>
      </g>
    </g>
  </g>
</svg>'.
	resultElement := parser resultElement.
	self assert: (resultElement isKindOf: BlElement).
	^ parser
]

{ #category : #accessing }
BlSvgSAXParserExamples >> importSvgWithRectOnlyWithStoke [
	<gtExample>
	| parser resultElement |
	parser := BlSvgSAXParser
			parse: '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns:xl="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" xmlns:dc="http://purl.org/dc/elements/1.1/" version="1.1" viewBox="0 0 16 16" width="16" height="16">
  <defs/>
  <g id="run_and_inspect_async_1" stroke="none" stroke-opacity="1" stroke-dasharray="none" fill="none" fill-opacity="1">
    <title>run and inspect async 1</title>
    <g id="run_and_inspect_async_1_Layer_1">
      <title>Layer 1</title>
      <g id="Graphic_30">
        <rect x="0" y="0" width="16" height="16" stroke="black" stroke-linecap="round" stroke-linejoin="miter" stroke-width="1"/>
      </g>
    </g>
  </g>
</svg>
'.
	resultElement := parser resultElement.
	self assert: (resultElement isKindOf: BlElement).
	self assert: resultElement border width equals: 1.
	self assert: resultElement background isTransparent.
	^ parser
]

{ #category : #accessing }
BlSvgSAXParserExamples >> importSvgWithSinglePath [
	<gtExample>
	| parser resultElement |
	parser := BlSvgSAXParser
			parse: '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg xmlns:xl="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" xmlns:dc="http://purl.org/dc/elements/1.1/" version="1.1" viewBox="0 0 16 16" width="16" height="16">
  <defs/>
  <g id="refresh_1" stroke="none" stroke-opacity="1" stroke-dasharray="none" fill="none" fill-opacity="1">
    <title>refresh 1</title>
    <g id="refresh_1_Layer_1">
      <title>Layer 1</title>
      <g id="Graphic_75">
        <path d="M 10.5 6 L 7 6 L 11 10 L 15 6 L 11.5 6 L 11.5 3 L 11.417824 3 L 10.5 3 L 3 3 L 2.4178236 3 L 2 3 L 2 13 L 2.4178236 13 L 3 13 L 11.417824 13 L 11.417824 12 L 3 12 L 3 4 L 10.5 4 Z" fill="black"/>
      </g>
    </g>
  </g>
</svg>
'.
	resultElement := parser resultElement.
	self assert: (resultElement isKindOf: BlElement).
	self assert: (resultElement children isEmpty).
	self assert: (resultElement geometry isKindOf: BlSvgPath).
	^ parser
]
