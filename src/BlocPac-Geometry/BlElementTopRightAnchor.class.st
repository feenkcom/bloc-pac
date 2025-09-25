Class {
	#name : #BlElementTopRightAnchor,
	#superclass : #BlAnchorRelativeToElementBounds,
	#category : #'BlocPac-Geometry-Anchors'
}

{ #category : #accessing }
BlElementTopRightAnchor class >> label [
	^ 'Top right'
]

{ #category : #geometry }
BlElementTopRightAnchor >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ aParentBounds topRight
]
