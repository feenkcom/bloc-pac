Class {
	#name : #BlItemsEnteredEvent,
	#superclass : #BlEvent,
	#instVars : [
		'items',
		'position',
		'mayAcceptItems'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #accessing }
BlItemsEnteredEvent >> items [
	^ items
]

{ #category : #accessing }
BlItemsEnteredEvent >> items: anObject [
	items := anObject
]

{ #category : #accessing }
BlItemsEnteredEvent >> mayAcceptItems [
	^ mayAcceptItems
]

{ #category : #accessing }
BlItemsEnteredEvent >> mayAcceptItems: anObject [
	mayAcceptItems := anObject
]

{ #category : #accessing }
BlItemsEnteredEvent >> position [
	^ position
]

{ #category : #accessing }
BlItemsEnteredEvent >> position: anObject [
	position := anObject
]

{ #category : #accessing }
BlItemsEnteredEvent >> sendTo: anObject [
	anObject itemsEnteredEvent: self
]
