Class {
	#name : 'BlShaperTriangle',
	#superclass : 'Object',
	#traits : 'TBlShaperFigure + TBlShaperMovable',
	#classTraits : 'TBlShaperFigure classTrait + TBlShaperMovable classTrait',
	#instVars : [
		'polygon'
	],
	#category : 'BlocPac-Geometry-Shaper'
}

{ #category : 'instance creation' }
BlShaperTriangle class >> points: aCollectionOfPoints [
	| theVertices theEdges |
	
	self
		assert: [ aCollectionOfPoints size = 3 ]
		description: [ 'A triangle can only be created from 3 points' ].
	
	^ BlShaperPolygon points: aCollectionOfPoints
]

{ #category : 'api - shape' }
BlShaperTriangle >> addEdge: aTBlShapeEdge after: anOtherShapeEdge [
	polygon addEdge: aTBlShapeEdge after: anOtherShapeEdge
]

{ #category : 'accessing' }
BlShaperTriangle >> bottomEdge [
	^ self edges at: 3
]

{ #category : 'accessing' }
BlShaperTriangle >> bottomEdge: aTBlShapeEdge [
	self edges at: 3 put: aTBlShapeEdge
]

{ #category : 'accessing' }
BlShaperTriangle >> bottomVertex [
	| allVertices aBottomVertex |
	
	allVertices := self vertices.
	aBottomVertex := allVertices first.
	allVertices allButFirstDo: [ :eachVertex |
		eachVertex y > aBottomVertex y
			ifTrue: [ aBottomVertex := eachVertex ] ].

	^ aBottomVertex
]

{ #category : 'api - shape' }
BlShaperTriangle >> edges [
	^ polygon edges
]

{ #category : 'accessing' }
BlShaperTriangle >> leftEdge [
	^ self edges at: 1
]

{ #category : 'accessing' }
BlShaperTriangle >> leftEdge: aTBlShapeEdge [
	self edges at: 1 put: aTBlShapeEdge
]

{ #category : 'accessing' }
BlShaperTriangle >> leftVertex [
	| allVertices aLeftVertex |
	
	allVertices := self vertices.
	aLeftVertex := allVertices first.
	allVertices allButFirstDo: [ :eachVertex |
		eachVertex x < aLeftVertex x
			ifTrue: [ aLeftVertex := eachVertex ] ].

	^ aLeftVertex
]

{ #category : 'initialization' }
BlShaperTriangle >> polygon: aPolygonShape [
	self
		assert: [ aPolygonShape edges size = 3 ]
		description: [ 'Triangle must have exactly 3 edges' ].
		
	polygon := aPolygonShape
]

{ #category : 'accessing' }
BlShaperTriangle >> rightEdge [
	^ self edges at: 2
]

{ #category : 'accessing' }
BlShaperTriangle >> rightEdge: aTBlShapeEdge [
	self edges at: 2 put: aTBlShapeEdge
]

{ #category : 'accessing' }
BlShaperTriangle >> rightVertex [
	| allVertices aRightVertex |
	
	allVertices := self vertices.
	aRightVertex := allVertices first.
	allVertices allButFirstDo: [ :eachVertex |
		eachVertex x > aRightVertex x
			ifTrue: [ aRightVertex := eachVertex ] ].

	^ aRightVertex
]

{ #category : 'accessing' }
BlShaperTriangle >> topVertex [
	| allVertices aTopVertex |
	
	allVertices := self vertices.
	aTopVertex := allVertices first.
	allVertices allButFirstDo: [ :eachVertex |
		eachVertex y < aTopVertex y
			ifTrue: [ aTopVertex := eachVertex ] ].

	^ aTopVertex
]
