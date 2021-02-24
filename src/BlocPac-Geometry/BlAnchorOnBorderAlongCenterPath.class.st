"
I will place the anchor on the border of nodes intersecting the line drawn between the centers of two nodes.

If the nodes overlap and the center line does not intersect the boundary, then the center itself will be the anchor.

[[[
view := GtMondrian new.
view nodes
	shape: [ :x |
		BlTextElement new
			text: (x asRopedText );
			border: (BlBorder paint: Color gray);
			padding: (BlInsets all: 5) ];
	with: { 'Foo' . 'Bar' } .

view edges
	fromAnchor: BlAnchorOnBorderAlongCenterPath;
	toAnchor: BlAnchorOnBorderAlongCenterPath;
	connect: { 'Foo' -> 'Bar' }
	from: #key to: #value.

view layout tree.
^ view
]]]

"
Class {
	#name : #BlAnchorOnBorderAlongCenterPath,
	#superclass : #BlNearestPositionAnchor,
	#category : #'BlocPac-Geometry-Anchors'
}

{ #category : #accessing }
BlAnchorOnBorderAlongCenterPath >> globalPositionWithin: aGeometryElement [
	"Compute and return a global position (in space) of this anchor"

	<return: #Point>
	| br edges path |
	br := self referenceElement boundsInSpace.
	edges := {(LineSegment from: br topLeft to: br topRight).
	(LineSegment from: br topRight to: br bottomRight).
	(LineSegment from: br bottomRight to: br bottomLeft).
	(LineSegment from: br bottomLeft to: br topLeft)}.
	path := LineSegment
		from: br center
		to: self nearestToElement boundsInSpace center.
	^ (edges collect: [ :each | each intersectionWith: path ])
		detect: #isNotNil
		ifNone: [ br center ]
]

{ #category : #accessing }
BlAnchorOnBorderAlongCenterPath >> label [
	<return: #String>
	
	^ 'Not sure what this is used for.'
]
