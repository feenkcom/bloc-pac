Class {
	#name : #BlShaperPolygon,
	#superclass : #Object,
	#traits : 'TBlShaperFigure + TBlShaperMovable',
	#classTraits : 'TBlShaperFigure classTrait + TBlShaperMovable classTrait',
	#instVars : [
		'edges'
	],
	#category : #'BlocPac-Geometry-Shaper'
}

{ #category : #'instance creation' }
BlShaperPolygon class >> points: aCollectionOfPoints [
	| theVertices theEdges |
	
	self
		assert: [ aCollectionOfPoints size > 1 ]
		description: [ 'A polygonmust have at least one edge' ].
	
	theVertices := aCollectionOfPoints collect: [ :eachPoint | BlShaperVertex point: eachPoint ].
	theEdges := (theVertices, { theVertices first }) overlappingPairsCollect: [ :aFromVertex :aToVertex |
		BlShaperLine new
			fromVertex: aFromVertex;
			toVertex: aToVertex ].
		
	^ self new edges: theEdges
]

{ #category : #'instance creation' }
BlShaperPolygon class >> rectangle: aRectangle [
	^ self points: {
		aRectangle topLeft.
		aRectangle topRight.
		aRectangle bottomRight.
		aRectangle bottomLeft
	}
]

{ #category : #'api - shape' }
BlShaperPolygon >> addEdge: aTBlShapeEdge after: anOtherShapeEdge [
	edges add: aTBlShapeEdge after: anOtherShapeEdge.
	aTBlShapeEdge figure: self
]

{ #category : #converting }
BlShaperPolygon >> buildPathOnSpartaCanvas: aCanvas [
	| aPathBuilder |
	
	aPathBuilder := aCanvas path.
	aPathBuilder moveTo: 0@0.
	self appendPathTo: aPathBuilder.
	^ aPathBuilder finish
]

{ #category : #'api - shape' }
BlShaperPolygon >> edges [
	^ edges
]

{ #category : #'api - shape' }
BlShaperPolygon >> edges: aCollectionOfEdges [
	edges := aCollectionOfEdges asOrderedCollection.
	edges do: [ :eachEdge | eachEdge figure: self ]
]

{ #category : #'gt-extension' }
BlShaperPolygon >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live';
		priority: 5;
		stencil: [
			BlElement new
				addEventHandler: BlPullHandler new;
				constraintsDo: [ :c |
					c ignoreByLayout.
					c horizontal matchParent.
					c vertical matchParent ];
				geometry: (BlPolygonGeometry vertices: (self vertices collect: #point));
				border: (BlBorder paint: Color gray width: 2) ]
]

{ #category : #initialization }
BlShaperPolygon >> initialize [
	super initialize.
	
	edges := OrderedCollection new
]

{ #category : #'api - decorator' }
BlShaperPolygon >> quadrilateral [
	^ BlShaperQuadrilateral new polygon: self
]

{ #category : #'api - shape' }
BlShaperPolygon >> removeEdge: aTBlShapeEdge [
	edges remove: aTBlShapeEdge
]

{ #category : #'api - decorator' }
BlShaperPolygon >> triangle [
	^ BlShaperTriangle new polygon: self
]
