"
Examples of two elements connected by an arrow, including rendering diagnostics.
"
Class {
	#name : #BlTwoElementsArrowExamples,
	#superclass : #Object,
	#category : #'BlocPac-Geometry-Examples-Examples'
}

{ #category : #examples }
BlTwoElementsArrowExamples >> renderedArrow [
	<gtExample>
	| container form |
	container := self twoElementsWithArrow.
	form := BlExporter form element: container; export.
	self assert: (form colorAt: 200 @ 100) equals: Color black.
	self assert: ((280 to: 299) anySatisfy: [ :x |
		(form colorAt: x @ 96) ~= Color white ]).
	self assert: ((280 to: 299) anySatisfy: [ :x |
		(form colorAt: x @ 103) ~= Color white ]).
	^ form
]

{ #category : #'examples - regression' }
BlTwoElementsArrowExamples >> renderedSimpleArrow [
	<gtExample>
	| container form |
	container := self twoElementsWithSimpleArrow.
	form := BlExporter form element: container; export.
	self assert: (form colorAt: 200 @ 100) equals: Color black.
	"The arrow wings must extend beyond the horizontal line's stroke."
	self
		assert: ((280 to: 299) anySatisfy: [ :x |
			(form colorAt: x @ 96) ~= Color white ])
		description: 'The simple arrowhead upper wing must be visible'.
	self
		assert: ((280 to: 299) anySatisfy: [ :x |
			(form colorAt: x @ 103) ~= Color white ])
		description: 'The simple arrowhead lower wing must be visible'.
	^ form
]

{ #category : #'examples - diagnosis' }
BlTwoElementsArrowExamples >> simpleArrowPrecisionDiagnosis [
	<gtExample>
	| container form builder shape current expected |
	container := self twoElementsWithSimpleArrow.
	form := self renderedSimpleArrow.
	builder := (Bloc preferableSpartaCanvas extent: 20 @ 20) path.
	builder moveTo: 0 @ 0.
	container forceLayout.
	shape := container children last toHead instVarNamed: 'arrowShape'.
	shape edges first appendPathTo: builder.
	current := builder currentPoint.
	expected := shape edges second fromVertex point.
	"The comparison must accommodate a single-precision canvas round trip."
	self assert: (current closeTo: expected precision: 0.00001).
	^ { current. expected. form }
]

{ #category : #'examples - diagnosis' }
BlTwoElementsArrowExamples >> simpleArrowWithConnectedPolygon [
	<gtExample>
	| container head shape form |
	container := self twoElementsWithSimpleArrow.
	container forceLayout.
	head := container children last toHead.
	shape := head instVarNamed: 'arrowShape'.
	"Keep exactly the same vertices, but use a connected polygon path."
	head geometry: (BlPolygonGeometry vertices:
		(shape edges collect: [ :edge | edge fromVertex point ])).
	form := BlExporter form element: container; export.
	self assert: ((280 to: 299) anySatisfy: [ :x |
		(form colorAt: x @ 96) ~= Color white ]).
	self assert: ((280 to: 299) anySatisfy: [ :x |
		(form colorAt: x @ 103) ~= Color white ]).
	^ form
]

{ #category : #examples }
BlTwoElementsArrowExamples >> twoElementsWithArrow [
	<gtExample>
	| container |
	container := self twoElementsWithSimpleArrow.
	container children last toHead: (BlArrowheadTriangle new
		scale: 4;
		background: Color black;
		border: (BlBorder paint: Color black width: 1)).
	^ container
]

{ #category : #examples }
BlTwoElementsArrowExamples >> twoElementsWithSimpleArrow [
	<gtExample>
	| container source target line |
	container := BlElement new
		size: 400 @ 200;
		background: Color white.
	source := BlElement new
		size: 60 @ 60;
		relocate: 40 @ 70;
		background: Color lightBlue.
	target := BlElement new
		size: 60 @ 60;
		relocate: 300 @ 70;
		background: Color lightGreen.
	line := BlLineElement new
		border: (BlBorder paint: Color black width: 2);
		fromAnchor: (BlElementCenterRightAnchor element: source);
		toAnchor: (BlElementCenterLeftAnchor element: target);
		toHead: (BlArrowheadSimpleArrow new
			border: (BlBorder paint: Color black width: 2);
			background: Color black).
	container addChildren: { source. target. line }.
	self assert: line hasToHead.
	self assert: line toHead parent equals: line.
	^ container
]
