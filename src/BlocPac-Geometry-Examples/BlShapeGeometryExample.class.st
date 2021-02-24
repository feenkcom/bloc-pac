Class {
	#name : #BlShapeGeometryExample,
	#superclass : #Object,
	#category : #'BlocPac-Geometry-Examples'
}

{ #category : #examples }
BlShapeGeometryExample >> defaultGeometry [
	<gtExample>
	| geometry |
	geometry := BlShaperGeometry new.
	
	self assert: geometry hasShapeBuilder.
	self assert: geometry extent equals: 150@100.
	self assert: geometry createVectorShape notNil.
	self assert: geometry createVectorShape class equals: BlShaperPolygon.
	
	^ geometry
]

{ #category : #'examples - elements' }
BlShapeGeometryExample >> elementLargeWithRectangleGeometry [
	<gtExample>
	| element |
	
	element := BlElement new 
		size: 150@150;
		border: (BlBorder paint: Color black width: 1);
		geometry: self geometryWithRectangleShapeWithArrow.
	
	self assert: element geometry notNil.
		
	^ element
]

{ #category : #'examples - elements' }
BlShapeGeometryExample >> elementWithRectangleGeometry [
	<gtExample>
	| element |
	
	element := BlElement new 
		size: 50@100;
		border: (BlBorder paint: Color black width: 1);
		geometry: self geometryWithRectangleShapeWithArrow.
	
	self assert: element geometry notNil.
		
	^ element
]

{ #category : #examples }
BlShapeGeometryExample >> geometryWithRectangleShapeWithArrow [
	<gtExample>
	| geometry |
	
	geometry := self defaultGeometry.
	geometry 	shape: [ :aRectangle |
		| aShape |
		aShape := BlShaperPolygon rectangle: aRectangle.
		aShape quadrilateral rightEdge
			moveBy: (40 @ 0);
			injectLineAt: 0.5 length: 20.
		
		(aShape edgeAt: 2) splitAt: 0.5.
		(aShape edgeAt: 3) toVertex moveBy: (40 @ -20).

		aShape ].

	self assert: geometry hasShapeBuilder.
	self assert: geometry createVectorShape class equals: BlShaperPolygon.

	^ geometry
]

{ #category : #examples }
BlShapeGeometryExample >> geometryWithRectangleShareInstance [
	<gtExample>
	| geometry |
	
	geometry := self defaultGeometry.
	geometry shape: (BlShaperPolygon 
		rectangle: (0@0 corner: 50@50)).
		
	self assert: geometry hasShapeBuilder.
	self 
		assert: geometry createVectorShape class 
		equals: BlShaperPolygon.
		
	^ geometry
]

{ #category : #examples }
BlShapeGeometryExample >> geometryWithSimpleRectangleShape [
	<gtExample>
	| geometry |
	
	geometry := BlShaperGeometry new.
	geometry shape: [ :aRectangle |
		BlShaperPolygon rectangle: aRectangle ].
	
	self assert: geometry hasShapeBuilder.
	self assert: geometry createVectorShape notNil.
	self assert: geometry createVectorShape class equals: BlShaperPolygon.
	
	^ geometry
]
