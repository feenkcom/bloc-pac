"
# Vertex
Connects two edges

"
Class {
	#name : #BlShaperVertex,
	#superclass : #Object,
	#traits : 'TBlShaperMovable',
	#classTraits : 'TBlShaperMovable classTrait',
	#instVars : [
		'point',
		'incomingEdge',
		'outgoingEdge'
	],
	#category : 'BlocPac-Geometry-Shaper'
}

{ #category : #accessing }
BlShaperVertex class >> point: aPoint [
	^ self new point: aPoint
]

{ #category : #'api - transformations' }
BlShaperVertex >> angleBetweenEdges [
	| edgeA edgeB anAngle |
	self assertTwoEdges.
	
	edgeA := self incomingEdge.
	edgeB := self outgoingEdge.
	
	anAngle := (edgeA vector asPoint angleWith: edgeB vector negated asPoint) radiansToDegrees.
	^ anAngle > 180
		ifTrue: [ 360 - anAngle ]
		ifFalse: [ anAngle ]
]

{ #category : #private }
BlShaperVertex >> assertTwoEdges [
	self
		assert: [ self outgoingEdge notNil ]
		description: [ 'Must have an outgoing edge' ].
		
	self
		assert: [ self incomingEdge notNil ]
		description: [ 'Must have an incoming edge' ].
		
	self
		assert: [ self incomingEdge figure == self outgoingEdge figure ]
		description: [ 'Must connect edges from the same figure' ].
]

{ #category : #'api - transformations' }
BlShaperVertex >> divide [
	| newFromVertex newToVertex aLine aFigure anIncomingEdge |
	
	self assertTwoEdges.

	anIncomingEdge := self incomingEdge.
	aFigure := anIncomingEdge figure.

	newFromVertex := BlShaperVertex new point: self point.
	newToVertex := BlShaperVertex new point: self point.

	self incomingEdge toVertex: newFromVertex.
	self outgoingEdge fromVertex: newToVertex.

	aLine := BlShaperLine new
		fromVertex: newFromVertex;
		toVertex:  newToVertex.

	aFigure addEdge: aLine after: anIncomingEdge.

	^ aLine
]

{ #category : #accessing }
BlShaperVertex >> incomingEdge [
	^ incomingEdge
]

{ #category : #accessing }
BlShaperVertex >> incomingEdge: anObject [
	incomingEdge := anObject
]

{ #category : #initialization }
BlShaperVertex >> initialize [
	super initialize.
]

{ #category : #'api - movable' }
BlShaperVertex >> moveBy: aPointOrVector [
	self point: (self point + aPointOrVector) asPoint
]

{ #category : #'api - transformations' }
BlShaperVertex >> moveToBuildAngle: anAngleInDegrees [
	| edgeA edgeB edgeC aPerpendicularLength aNewPoint |
	self assertTwoEdges.
	
	edgeA := self incomingEdge.
	edgeB := self outgoingEdge.
	
	edgeC := BlShaperLine new
		fromVertex: edgeA fromVertex copy;
		toVertex: edgeB toVertex copy.
		
	"tan(alpha) = (edgeC / 2) / perpendicular.
	perpendicular := edgeC / (2 * tan(alpha))"
	aPerpendicularLength := (edgeC length / (2.0 * (anAngleInDegrees degreesToRadians / 2.0) tan)).
	
	aNewPoint := edgeC middle + (edgeC vector normal negated * aPerpendicularLength).
	self point: aNewPoint asPoint
]

{ #category : #accessing }
BlShaperVertex >> outgoingEdge [
	^ outgoingEdge
]

{ #category : #accessing }
BlShaperVertex >> outgoingEdge: anObject [
	outgoingEdge := anObject
]

{ #category : #accessing }
BlShaperVertex >> point [
	^ point
]

{ #category : #accessing }
BlShaperVertex >> point: anObject [
	point := anObject
]

{ #category : #copying }
BlShaperVertex >> postCopy [
	incomingEdge := nil.
	outgoingEdge := nil
]

{ #category : #printing }
BlShaperVertex >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' point: ';
		print: point
]

{ #category : #accessing }
BlShaperVertex >> removeIncomingEdge [
	incomingEdge := nil
]

{ #category : #accessing }
BlShaperVertex >> removeOutgoingEdge [
	outgoingEdge := nil
]

{ #category : #accessing }
BlShaperVertex >> x [
	^ self point x
]

{ #category : #accessing }
BlShaperVertex >> y [
	^ self point y
]
