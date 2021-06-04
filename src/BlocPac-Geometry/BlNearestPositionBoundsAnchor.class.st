"
I find the nearest point that lies on bounds rectangle of a reference element to the center of the given element

"
Class {
	#name : #BlNearestPositionBoundsAnchor,
	#superclass : #BlNearestPositionAnchor,
	#category : #'BlocPac-Geometry-Anchors'
}

{ #category : #accessing }
BlNearestPositionBoundsAnchor class >> label [
	^ 'Rectangle'
]

{ #category : #geometry }
BlNearestPositionBoundsAnchor >> globalPositionWithin: aGeometryElement [
	"Compute and return a global position (in space) of this anchor"

	<return: #Point>
	| br edges path result |
	br := self referenceElement boundsInSpace.
	edges := {(BlLine from: br topLeft to: br topRight).
	(BlLine from: br topRight to: br bottomRight).
	(BlLine from: br bottomRight to: br bottomLeft).
	(BlLine from: br bottomLeft to: br topLeft)}.
	path := BlLine
		from: br center
		to: self nearestToElement boundsInSpace center.
	^ edges
		detect: [ :each | 
			result := each intersectionWith: path.
			result isNotNil ]
		ifFound: [ result ]
		ifNone: [ br center ]
]
