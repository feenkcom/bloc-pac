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
BlNearestPositionBoundsAnchor >> positionForAnchoredElement: aGeometryElement within: aCommonParent [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	| br edges path result |

	br := self referenceElement bounds inParent: aCommonParent.
	edges := {
		(BlLineGeometry from: br topLeft to: br topRight).
		(BlLineGeometry from: br topRight to: br bottomRight).
		(BlLineGeometry from: br bottomRight to: br bottomLeft).
		(BlLineGeometry from: br bottomLeft to: br topLeft)}.
	
	path := BlLineGeometry
		from: br center
		to: (self nearestToElement bounds inParent: aCommonParent) center.
	^ edges
		detect: [ :each | 
			result := each intersectionWith: path.
			result isNotNil ]
		ifFound: [ result ]
		ifNone: [ br center ]
]
