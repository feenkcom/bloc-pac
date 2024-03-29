"
I find the nearest point that lies on a circle of a reference element to the center of the given element.

Circle radius is computed as a half of the maximum of the height and width

"
Class {
	#name : #BlNearestPositionTightCircleAnchor,
	#superclass : #BlNearestPositionAnchor,
	#category : #'BlocPac-Geometry-Anchors'
}

{ #category : #accessing }
BlNearestPositionTightCircleAnchor class >> label [
	^ 'Circle'
]

{ #category : #geometry }
BlNearestPositionTightCircleAnchor >> positionForAnchoredElement: aGeometryElement within: aCommonParent [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	| aRadius aReferenceBounds aNearestBounds aDirectionVector |
	
	aReferenceBounds := self referenceElement bounds inParent: aCommonParent.
	aNearestBounds := self nearestToElement bounds inParent: aCommonParent.
	
	aDirectionVector := (aNearestBounds center - aReferenceBounds center) asBlocVector.
	aRadius := (aReferenceBounds extent max / 2.0) min: (aDirectionVector length).
	
	aDirectionVector := (aDirectionVector length isZero)
		ifTrue: [ BlVector x: 1 y: 0 ]
		ifFalse: [ aDirectionVector normalized ].

	^ aReferenceBounds center + (aDirectionVector * aRadius) asPoint
]
