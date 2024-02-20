Class {
	#name : #BlDragItemStencil,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'dragItem'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #accessing }
BlDragItemStencil >> buildDefault [
	^ BlElement new
		size: 20@20;
		background: Color blue
]

{ #category : #accessing }
BlDragItemStencil >> dragItem [
	^ dragItem
]

{ #category : #accessing }
BlDragItemStencil >> dragItem: anObject [
	dragItem := anObject
]

{ #category : #accessing }
BlDragItemStencil >> paramsOn: aStencilExecutor [
	aStencilExecutor
		push: self dragItem
]

{ #category : #accessing }
BlDragItemStencil >> reset [
	super reset.
	
	dragItem := nil
]
