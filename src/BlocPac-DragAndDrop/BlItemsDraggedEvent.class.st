Class {
	#name : #BlItemsDraggedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'items',
		'position',
		'offset',
		'dragContainer'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #accessing }
BlItemsDraggedEvent >> dragContainer [
	^ dragContainer
]

{ #category : #accessing }
BlItemsDraggedEvent >> dragContainer: anObject [
	dragContainer := anObject
]

{ #category : #accessing }
BlItemsDraggedEvent >> dragContainerCenter [
	"Return a location of the center of the dragging container"
	<return: #Point>

	^ self position - self offset + (self dragContainer extent / 2.0)
]

{ #category : #accessing }
BlItemsDraggedEvent >> items [
	^ items
]

{ #category : #accessing }
BlItemsDraggedEvent >> items: anObject [
	items := anObject
]

{ #category : #accessing }
BlItemsDraggedEvent >> offset [
	^ offset
]

{ #category : #accessing }
BlItemsDraggedEvent >> offset: anObject [
	offset := anObject
]

{ #category : #accessing }
BlItemsDraggedEvent >> position [
	"Mouse pointer position given in the local coordinates of the event's target"
	<return: #Point>

	^ position
]

{ #category : #accessing }
BlItemsDraggedEvent >> position: anObject [
	position := anObject
]

{ #category : #accessing }
BlItemsDraggedEvent >> sendTo: anObject [
	anObject itemsDraggedEvent: self
]
