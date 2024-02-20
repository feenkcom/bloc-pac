Class {
	#name : #BlAboutToBeDroppedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'dropTarget'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #accessing }
BlAboutToBeDroppedEvent >> dropTarget [
	^ dropTarget
]

{ #category : #accessing }
BlAboutToBeDroppedEvent >> dropTarget: anObject [
	dropTarget := anObject
]
