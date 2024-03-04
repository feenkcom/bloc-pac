Class {
	#name : #BlItemsLeftEvent,
	#superclass : #BlEvent,
	#instVars : [
		'position'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #accessing }
BlItemsLeftEvent >> position [
	^ position
]

{ #category : #accessing }
BlItemsLeftEvent >> position: anObject [
	position := anObject
]

{ #category : #accessing }
BlItemsLeftEvent >> sendTo: anObject [
	anObject itemsLeftEvent: self
]
