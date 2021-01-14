Class {
	#name : #BlPolygonElementExamples,
	#superclass : #BlGeometryElementExamples,
	#category : #'BlocPac-Geometry-Examples'
}

{ #category : #'instance creation' }
BlPolygonElementExamples >> attachPoint [
	^ super attachPoint size: 10@10
]

{ #category : #examples }
BlPolygonElementExamples >> octagon [
	<gtExample>
	| n aPolygon theVertices theCorners theAnchors |
	
	n := 8.
	theVertices := (1 to: n) collect: [ :i |
		| angle |
		angle := (i * (360 / n)) degreesToRadians.
		(75 * (angle sin @ angle cos)) + (75@75) ].
	
	theCorners := theVertices collect: [ :eachPoint | self attachPoint relocate: eachPoint ].
	theAnchors := theCorners collect: [ :eachCorner | BlElementCenterAnchor element: eachCorner ].
	
	aPolygon := BlPolygonElement new
		anchors: theAnchors;
		background: (Color gray alpha: 0.3);
		border: (BlBorder paint: Color gray width: 2).

	^ self container
		addChild: aPolygon;
		addChildren: theCorners
]

{ #category : #examples }
BlPolygonElementExamples >> rectangle [
	<gtExample>
	| aPolygon theVertices theCorners theAnchors |
	
	theVertices := { 
		0@0.
		200@0.
		200@100.
		0@100.
	}.
	
	theCorners := theVertices collect: [ :eachPoint | self attachPoint relocate: eachPoint ].
	theAnchors := theCorners collect: [ :eachCorner | BlElementCenterAnchor element: eachCorner ].
	
	aPolygon := BlPolygonElement new
		anchors: theAnchors;
		background: (Color gray alpha: 0.3);
		border: (BlBorder paint: Color gray width: 2).

	^ self container
		addChild: aPolygon;
		addChildren: theCorners
]

{ #category : #examples }
BlPolygonElementExamples >> square [
	<gtExample>
	| aPolygon theVertices theCorners theAnchors |
	
	theVertices := { 
		0@0.
		100@0.
		100@100.
		0@100.
	}.
	
	theCorners := theVertices collect: [ :eachPoint | self attachPoint relocate: eachPoint ].
	theAnchors := theCorners collect: [ :eachCorner | BlElementCenterAnchor element: eachCorner ].
	
	aPolygon := BlPolygonElement new
		anchors: theAnchors;
		background: (Color gray alpha: 0.3);
		border: (BlBorder paint: Color gray width: 2).

	^ self container
		addChild: aPolygon;
		addChildren: theCorners
]

{ #category : #examples }
BlPolygonElementExamples >> triangle [
	<gtExample>
	| aPolygon theVertices theCorners theAnchors |
	
	theVertices := { 
		100@0.
		175@150.
		25@150.
	}.
	
	theCorners := theVertices collect: [ :eachPoint | self attachPoint relocate: eachPoint ].
	theAnchors := theCorners collect: [ :eachCorner | BlElementCenterAnchor element: eachCorner ].
	
	aPolygon := BlPolygonElement new
		anchors: theAnchors;
		background: (Color gray alpha: 0.3);
		border: (BlBorder paint: Color gray width: 2).

	^ self container
		addChild: aPolygon;
		addChildren: theCorners
]
