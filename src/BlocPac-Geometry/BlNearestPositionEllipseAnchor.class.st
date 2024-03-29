"
I find the nearest point that lies on an ellipse of a reference element to the center of the given element.

Ellipse radii are computed based as a half of the width and the height of the reference element

"
Class {
	#name : #BlNearestPositionEllipseAnchor,
	#superclass : #BlNearestPositionAnchor,
	#category : #'BlocPac-Geometry-Anchors'
}

{ #category : #accessing }
BlNearestPositionEllipseAnchor class >> label [
	^ 'Ellipse'
]

{ #category : #geometry }
BlNearestPositionEllipseAnchor >> positionForAnchoredElement: aGeometryElement within: aCommonParent [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	| aMajor aMinor aReferenceBounds aNearestBounds aDirectionVector k x y aMetric intersection |
	
	aReferenceBounds := self referenceElement bounds inParent: aCommonParent.
	aNearestBounds := self nearestToElement bounds inParent: aCommonParent.
	
	aDirectionVector := (aNearestBounds center - aReferenceBounds center) asBlocVector.
	
	aMajor := (aReferenceBounds width / 2.0).
	aMinor := (aReferenceBounds height / 2.0).
	
	aMetric := ((aMajor * aMajor * aDirectionVector y * aDirectionVector y) +
				(aMinor * aMinor * aDirectionVector x * aDirectionVector x)) sqrt.
	
	k := aMetric isZero
		ifTrue: [ 0 ]
		ifFalse: [ (aMajor * aMinor) / aMetric ].
				
	x := k * aDirectionVector x.
	y := k * aDirectionVector y.
	
	intersection := ((x @ y) distanceTo: aDirectionVector) < ((x @ y) negated distanceTo: aDirectionVector)
		ifTrue: [ (x @ y) ]
		ifFalse: [ (x @ y) negated ].
		
	^ aReferenceBounds center + intersection
]
