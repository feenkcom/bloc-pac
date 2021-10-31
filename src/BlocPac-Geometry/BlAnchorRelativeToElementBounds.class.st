Class {
	#name : #BlAnchorRelativeToElementBounds,
	#superclass : #BlAnchorRelativeToElement,
	#category : #'BlocPac-Geometry-Anchors'
}

{ #category : #geometry }
BlAnchorRelativeToElementBounds >> positionForAnchoredElement: aGeometryElement within: aCommonParent [
	"Compute and return a position of this anchor within a common parent"
	<return: #Point>

	^ self positionWithinBounds: (self referenceElement bounds inParent: aCommonParent)
]

{ #category : #geometry }
BlAnchorRelativeToElementBounds >> positionWithinBounds: aParentBounds [
	"Compute and return a position of this anchor within provided bounds"
	<return: #Point>

	^ self subclassResponsibility
]
