Class {
	#name : 'BlShaperQuadrilateral',
	#superclass : 'Object',
	#traits : 'TBlShaperFigure + TBlShaperMovable',
	#classTraits : 'TBlShaperFigure classTrait + TBlShaperMovable classTrait',
	#instVars : [
		'polygon'
	],
	#category : 'BlocPac-Geometry-Shaper'
}

{ #category : 'api - shape' }
BlShaperQuadrilateral >> addEdge: aTBlShapeEdge after: anOtherShapeEdge [
	polygon addEdge: aTBlShapeEdge after: anOtherShapeEdge
]

{ #category : 'accessing' }
BlShaperQuadrilateral >> bottomEdge [
	^ self edgeAt: 3
]

{ #category : 'api - shape' }
BlShaperQuadrilateral >> edges [
	^ polygon edges
]

{ #category : 'accessing' }
BlShaperQuadrilateral >> leftEdge [
	^ self edgeAt: 4
]

{ #category : 'accessing' }
BlShaperQuadrilateral >> polygon: aPolygonShape [
	self
		assert: [ aPolygonShape edges size = 4 ]
		description: [ 'Quadrileral must have exactly 4 edges' ].
		
	polygon := aPolygonShape
]

{ #category : 'accessing' }
BlShaperQuadrilateral >> rightEdge [
	^ self edgeAt: 2
]

{ #category : 'accessing' }
BlShaperQuadrilateral >> topEdge [
	^ self edgeAt: 1
]
