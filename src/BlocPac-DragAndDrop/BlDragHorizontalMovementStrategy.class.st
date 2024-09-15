Class {
	#name : #BlDragHorizontalMovementStrategy,
	#superclass : #BlDragMovementStrategy,
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #'as yet unclassified' }
BlDragHorizontalMovementStrategy >> drag: aDraggedContainer to: aPoint withOffset: anOffset [
	"Drag a container with all previews to a given point in the parent coordinate of the container"

	aDraggedContainer relocate: (aPoint - anOffset) x @ aDraggedContainer measuredBounds position y
]
