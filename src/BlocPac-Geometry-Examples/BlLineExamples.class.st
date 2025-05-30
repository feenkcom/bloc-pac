"
I contain examples and a few usecases of `=BlLineElement`=

"
Class {
	#name : #BlLineExamples,
	#superclass : #BlGeometryElementExamples,
	#category : #'BlocPac-Geometry-Examples'
}

{ #category : #benchmark }
BlLineExamples >> benchmark_lines_10000 [
	<gtExample>
	<return: #BlElement>
	| theLines |
	theLines := 10000
			timesCollect: [ :i | 
				self grayLine
					fromAnchor: (BlAbsolutePositionAnchor
							position: ((i atRandom cos * 100) sin abs * 800 abs)
									@ ((i atRandom negated sin * 300) cos abs * 600));
					toAnchor: (BlAbsolutePositionAnchor
							position: ((i atRandom negated sin * 300) cos abs * 800 abs) @ (i atRandom cos * 600) abs) ].

	^ self container
		size: 850 @ 650;
		addChildren: theLines
]

{ #category : #'example - visual properties' }
BlLineExamples >> blueLine [
	<gtExample>
	<return: #BlLineElement>
	^ self line border: (BlBorder paint: Color blue width: 2)
]

{ #category : #'instance creation' }
BlLineExamples >> box [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 100 @ 100;
		background: (Color gray alpha: 0.3);
		border: (BlBorder builder
				width: 1;
				paint: Color gray;
				build);
		layout: BlFrameLayout new;
		addEventHandler: BlPullHandler new;
		yourself
]

{ #category : #'instance creation' }
BlLineExamples >> circleAttachPoint [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		geometry: BlEllipseGeometry new;
		size: 75 @ 75;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlPullHandler new
]

{ #category : #'example - composite' }
BlLineExamples >> connectGridWith12Lines [
	<gtExample>
	<return: #BlElement>
	| aGridElement anAttachPoint lines |
	aGridElement := self gridWith12Cells.
	anAttachPoint := self attachPoint.

	lines := 12 timesCollect: [ self grayLine ].

	aGridElement relocate: 50 @ 50.

	anAttachPoint relocate: 500 @ 400.

	lines
		with: aGridElement children
		do: [ :aLine :aGridCell | 
			aLine
				fromAnchor: (BlElementCenterAnchor element: aGridCell);
				toAnchor: (BlElementCenterAnchor element: anAttachPoint) ].

	^ self container
		size: 600 @ 600;
		addChild: anAttachPoint;
		addChild: aGridElement;
		addChildren: lines;
		yourself
]

{ #category : #'example - composite' }
BlLineExamples >> connectGridWith1Lines [
	<gtExample>
	<return: #BlElement>
	| aGridElement anAttachPoint aLine |
	aGridElement := self gridWith12Cells.
	anAttachPoint := self attachPoint.

	aLine := self grayLine.

	aGridElement relocate: 50 @ 50.

	anAttachPoint relocate: 500 @ 400.

	aLine
		fromAnchor: (BlElementCenterAnchor element: aGridElement children first);
		toAnchor: (BlElementCenterAnchor element: anAttachPoint).

	^ self container
		size: 600 @ 600;
		addChild: anAttachPoint;
		addChild: aGridElement;
		addChild: aLine;
		yourself
]

{ #category : #'example - composite' }
BlLineExamples >> connectTwoGridsWith6Lines [
	<gtExample>
	<return: #BlElement>
	| lines aLeftGridElement aRightGridElement |
	lines := 6 timesCollect: [ self grayLine ].

	aLeftGridElement := self gridColumnWith10Cells.
	aRightGridElement := self gridColumnWith6Cells.

	aLeftGridElement relocate: 50 @ 55.

	aRightGridElement relocate: 500 @ 45.

	lines
		withIndexDo: [ :aLine :anIndex | 
			aLeftGridElement children
				detect: [ :aCellGrid | (aCellGrid userData at: #entity) = anIndex ]
				ifFound: [ :aLeftCell | 
					aRightGridElement children
						detect: [ :aCellGrid | (aCellGrid userData at: #entity) = anIndex ]
						ifFound: [ :aRightCell | 
							aLine
								fromAnchor: (BlElementCenterAnchor element: aLeftCell);
								toAnchor: (BlElementCenterAnchor element: aRightCell) ] ] ].

	^ self container
		size: 600 @ 600;
		addChild: aLeftGridElement;
		addChild: aRightGridElement;
		addChildren: lines;
		yourself
]

{ #category : #'example - connections' }
BlLineExamples >> draggableLineWithTwoAnchors [
	<gtExample>
	<return: #BlElement>
	| fromElement toElement line container |
	fromElement := BlElement new
			size: 20 @ 20;
			geometry: BlCircleGeometry new;
			relocate: 75 @ 140;
			addEventHandler: BlPullHandler new;
			background: Color gray.

	toElement := BlElement new
			size: 20 @ 20;
			geometry: BlCircleGeometry new;
			relocate: 200 @ 240;
			addEventHandler: BlPullHandler new;
			background: Color gray.

	line := BlLineElement new
			fromAnchor: (BlElementCenterAnchor element: fromElement);
			toAnchor: (BlElementCenterAnchor element: toElement);
			border: (BlBorder paint: Color blue width: 4);
			addEventHandler: BlPullHandler new;
			when: BlPullStartEvent
				do: [ :anEvent | 
					fromElement userData at: #initialDragPosition put: fromElement position.
					toElement userData at: #initialDragPosition put: toElement position ];
			when: BlPullEvent
				do: [ :anEvent | 
					fromElement
						relocate: (fromElement userData at: #initialDragPosition) + anEvent absoluteDelta.
					toElement
						relocate: (toElement userData at: #initialDragPosition) + anEvent absoluteDelta ];
			when: BlMouseEnterEvent
				do: [ :anEvent | anEvent currentTarget border: (BlBorder paint: Color red width: 4) ];
			when: BlMouseLeaveEvent
				do: [ :anEvent | anEvent currentTarget border: (BlBorder paint: Color blue width: 4) ];
			yourself.

	container := BlElement new
			background: Color white;
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.

	container
		addChildren: {line.
				fromElement.
				toElement}.
	^ container
]

{ #category : #'example - visual properties' }
BlLineExamples >> grayLine [
	<gtExample>
	<return: #BlLineElement>
	^ self line border: (BlBorder paint: Color darkGray width: 0.25)
]

{ #category : #'instance creation' }
BlLineExamples >> grid [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		background: Color veryVeryLightGray;
		layout: (BlGridLayout vertical cellSpacing: 10);
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		yourself
]

{ #category : #'instance creation' }
BlLineExamples >> gridCell [
	<gtExample>
	<return: #BlTextElement>
	^ BlTextElement new
		background: Color veryLightGray;
		padding: (BlInsets all: 10);
		constraintsDo: [ :c | 
			c grid horizontal alignCenter.
			c grid vertical alignCenter ];
		yourself
]

{ #category : #'example - grid' }
BlLineExamples >> gridColumnWith10Cells [
	<gtExample>
	<return: #BlElement>
	^ self gridColumnWith: 10
]

{ #category : #'example - grid' }
BlLineExamples >> gridColumnWith6Cells [
	<gtExample>
	<return: #BlElement>
	^ self gridColumnWith: 6
]

{ #category : #'example - grid' }
BlLineExamples >> gridColumnWith: aNumberOfCells [
	<gtExample>
	
	| cells |
	cells := (1 to: aNumberOfCells) collect: [ :i | self gridCell ].
	cells
		withIndexDo:
			[ :aCell :anIndex | 
			aCell userData at: #entity put: anIndex.
			aCell text: anIndex asString asRopedText ].
	^ (self grid)
		layoutDo: [ :aGridLayout | aGridLayout columnCount: 1 ];
		addChildren: cells;
		yourself
]

{ #category : #'example - grid' }
BlLineExamples >> gridWith12Cells [
	<gtExample>
	<return: #BlElement>
	| cells |
	cells := (1 to: 12) collect: [ :i | self gridCell ].
	cells
		withIndexDo: [ :aCell :anIndex | 
			aCell userData at: #entity put: anIndex.
			aCell text: anIndex asString asRopedText ].
	^ self grid
		layoutDo: [ :aGridLayout | aGridLayout rowCount: 4 ];
		addChildren: cells;
		yourself
]

{ #category : #'example - geometry' }
BlLineExamples >> horizontalLine [
	<gtExample>
	<return: #BlElement>
	| redLine aContainer w2 |
	redLine := self redLine.
	w2 := redLine border width / 2.
	aContainer := self container.
	aContainer addChild: redLine.

	redLine fromAnchor: (BlAbsolutePositionAnchor position: 50 @ 200).
	redLine toAnchor: (BlAbsolutePositionAnchor position: 300 @ 200).

	redLine forceLayout.

	self assert: redLine position equals: 50 @ 200.
	self assert: redLine extent equals: 250 @ 0.
	self assert: redLine fromDirection equals: (BlVector2D x: -250 y: 0).
	self assert: redLine toDirection equals: (BlVector2D x: 250 y: 0).
	self assert: redLine geometry from equals: -1 @ 0.
	self assert: redLine geometry to equals: 251 @ 0.

	self assert: redLine layoutBounds equals: (50 @ 200 extent: 250 @ 0).
	self assert: redLine geometryBounds equals: (-1 @ (0 - w2) corner: 251 @ w2).
	self
		assert: redLine visualBounds
		equals: (-3.8284271247461903 @ -2.8284271247461903
				corner: 253.82842712474618 @ 2.8284271247461903).
	self
		assert: redLine effectBounds
		equals: (-3.8284271247461903 @ -2.8284271247461903
				corner: 253.82842712474618 @ 2.8284271247461903).
	self
		assert: redLine invalidationBounds
		equals: (-3.8284271247461903 @ -2.8284271247461903
				corner: 253.82842712474618 @ 2.8284271247461903).

	^ aContainer
]

{ #category : #'instance creation' }
BlLineExamples >> line [
	<gtExample>
	<return: #BlLineElement>
	^ BlLineElement new
		zIndex: 10;
		yourself
]

{ #category : #'example - connections' }
BlLineExamples >> lineBetweenElementBottomAndTopCenters [
	<gtExample>
	<return: #BlElement>
	| redLine fromBox toBox |
	fromBox := self box.
	fromBox relocate: 150 @ 50.
	fromBox
		when: BlClickEvent
		do: [ :anEvent | anEvent currentTarget addAnimation: (BlTransformAnimation scale: 0.75) ].

	toBox := self box.
	toBox relocate: 250 @ 250.
	toBox
		when: BlClickEvent
		do: [ :anEvent | anEvent currentTarget addAnimation: (BlTransformAnimation scale: 1.25) ].

	redLine := self redLine.

	redLine fromAnchor: (BlElementBottomCenterAnchor element: fromBox).
	redLine toAnchor: (BlElementTopCenterAnchor element: toBox).

	^ self container
		addChildren: {fromBox.
				toBox.
				redLine}
]

{ #category : #'example - connections' }
BlLineExamples >> lineBetweenElementBottomCenters [
	<gtExample>
	<return: #BlElement>
	| redLine fromBox toBox |
	fromBox := self box.
	fromBox relocate: 50 @ 50.

	toBox := self box.
	toBox relocate: 250 @ 250.

	redLine := self redLine.

	redLine fromAnchor: (BlElementBottomCenterAnchor element: fromBox).
	redLine toAnchor: (BlElementBottomCenterAnchor element: toBox).

	^ self container
		addChildren: {fromBox.
				toBox.
				redLine}
]

{ #category : #'example - connections' }
BlLineExamples >> lineBetweenElementCenters [
	<gtExample>
	<return: #BlElement>
	| redLine fromBox toBox |
	fromBox := self box.
	fromBox relocate: 50 @ 50.

	toBox := self box.
	toBox relocate: 250 @ 250.

	redLine := self redLine.

	redLine fromAnchor: (BlElementCenterAnchor element: fromBox).
	redLine toAnchor: (BlElementCenterAnchor element: toBox).

	^ self container
		addChildren: {fromBox.
				toBox.
				redLine}
]

{ #category : #'example - connections' }
BlLineExamples >> lineBetweenSubElements [
	<gtExample>
	<return: #BlElement>
	| attachFrom attachTo fromBox toBox redLine |
	attachFrom := self attachPoint.
	attachFrom
		constraintsDo: [ :c | 
			c frame horizontal alignRight.
			c frame vertical alignCenter ].

	attachTo := self attachPoint.
	attachTo
		constraintsDo: [ :c | 
			c frame horizontal alignLeft.
			c frame vertical alignBottom ].

	fromBox := self box.
	fromBox relocate: 50 @ 50.
	fromBox addChild: attachFrom.

	toBox := self box.
	toBox relocate: 250 @ 250.
	toBox addChild: attachTo.

	redLine := self redLine.

	redLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redLine toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {fromBox.
				toBox.
				redLine}
]

{ #category : #'example - connections' }
BlLineExamples >> lineWithAnchors [
	<gtExample>
	<return: #BlElement>
	| redLine attachFrom attachTo |
	redLine := self redLine.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 400 @ 300.

	redLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redLine toAnchor: (BlElementCenterAnchor element: attachTo).


	^ self container
		addChildren: {redLine.
				attachFrom.
				attachTo}
]

{ #category : #'example - connections' }
BlLineExamples >> lineWithNearestBoundsAnchors [
	<gtExample>
	<return: #BlElement>
	| redLine attachFrom attachTo |
	redLine := self redLine.

	attachFrom := self rectangleAttachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self rectangleAttachPoint.
	attachTo relocate: 400 @ 300.

	redLine
		fromAnchor: (BlNearestPositionBoundsAnchor nearestTo: attachTo from: attachFrom).
	redLine
		toAnchor: (BlNearestPositionBoundsAnchor nearestTo: attachFrom from: attachTo).

	^ self container
		addChildren: {redLine.
				attachFrom.
				attachTo}
]

{ #category : #'example - connections' }
BlLineExamples >> lineWithNearestCircleAnchors [
	<gtExample>
	<return: #BlElement>
	| redLine attachFrom attachTo |
	redLine := self redLine.

	attachFrom := self circleAttachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self circleAttachPoint.
	attachTo relocate: 400 @ 300.

	redLine
		fromAnchor: (BlNearestPositionTightCircleAnchor nearestTo: attachTo from: attachFrom).
	redLine
		toAnchor: (BlNearestPositionTightCircleAnchor nearestTo: attachFrom from: attachTo).

	^ self container
		addChildren: {redLine.
				attachFrom.
				attachTo}
]

{ #category : #'instance creation' }
BlLineExamples >> rectangleAttachPoint [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 75 @ 75;
		background: (Color blue alpha: 0.3);
		border: BlBorder empty;
		addEventHandler: BlPullHandler new
]

{ #category : #'example - visual properties' }
BlLineExamples >> redLine [
	<gtExample>
	<return: #BlLineElement>
	| aLine |
	aLine := self line.
	aLine border: (BlBorder paint: Color red width: 2).

	self assert: aLine border width equals: 2.
	self assert: aLine clipChildren.

	^ aLine
]

{ #category : #'example - connections' }
BlLineExamples >> twoLines [
	<gtExample>
	<return: #BlElement>
	| redLine blueLine attachPoint |
	redLine := self redLine.
	blueLine := self blueLine.

	attachPoint := self attachPoint.
	attachPoint relocate: 300 @ 130.

	redLine fromAnchor: (BlAbsolutePositionAnchor position: 100 @ 100).
	redLine toAnchor: (BlElementCenterAnchor element: attachPoint).

	blueLine fromAnchor: (BlElementCenterAnchor element: attachPoint).
	blueLine toAnchor: (BlAbsolutePositionAnchor position: 400 @ 300).

	^ self container
		addChildren: {redLine.
				blueLine.
				attachPoint}
]

{ #category : #'example - geometry' }
BlLineExamples >> verticalLine [
	<gtExample>
	<return: #BlElement>
	| redLine aContainer w2 |
	redLine := self redLine.
	w2 := redLine border width / 2.
	aContainer := self container.
	aContainer addChild: redLine.

	redLine fromAnchor: (BlAbsolutePositionAnchor position: 50 @ 50).
	redLine toAnchor: (BlAbsolutePositionAnchor position: 50 @ 300).

	redLine forceLayout.

	self assert: redLine position equals: 50 @ 50.
	self assert: redLine extent equals: 0 @ 250.
	self assert: redLine fromDirection equals: (BlVector2D x: 0 y: -250).
	self assert: redLine toDirection equals: (BlVector2D x: 0 y: 250).
	self assert: redLine geometry from equals: 0 @ -1.
	self assert: redLine geometry to equals: 0 @ 251.

	self assert: redLine layoutBounds equals: (50 @ 50 extent: 0 @ 250).
	self
		assert: redLine geometryBounds
		equals: ((0 - w2) @ -1.0 corner: w2 @ 251.0).
	self
		assert: redLine visualBounds
		equals: (-2.8284271247461903 @ -3.8284271247461903
				corner: 2.8284271247461903 @ 253.82842712474618).
	self
		assert: redLine effectBounds
		equals: (-2.8284271247461903 @ -3.8284271247461903
				corner: 2.8284271247461903 @ 253.82842712474618).
	self
		assert: redLine invalidationBounds
		equals: (-2.8284271247461903 @ -3.8284271247461903
				corner: 2.8284271247461903 @ 253.82842712474618).

	^ aContainer
]
