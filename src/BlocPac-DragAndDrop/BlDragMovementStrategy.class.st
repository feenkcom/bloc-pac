Class {
	#name : #BlDragMovementStrategy,
	#superclass : #Object,
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #'drag and drop' }
BlDragMovementStrategy >> drag: aDraggedContainer to: aPoint withOffset: anOffset [
	self subclassResponsibility
]
