Class {
	#name : #BlItemsDroppedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'items',
		'position'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #accessing }
BlItemsDroppedEvent >> items [
	^ items
]

{ #category : #accessing }
BlItemsDroppedEvent >> items: anObject [
	items := anObject
]

{ #category : #accessing }
BlItemsDroppedEvent >> position [
	^ position
]

{ #category : #accessing }
BlItemsDroppedEvent >> position: anObject [
	position := anObject
]

{ #category : #accessing }
BlItemsDroppedEvent >> sendTo: anObject [
	anObject itemsDroppedEvent: self
]
