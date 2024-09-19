Class {
	#name : #BlDragToSignal,
	#superclass : #BlDragAndDropSignal,
	#instVars : [
		'container',
		'position',
		'offset'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #accessing }
BlDragToSignal >> container [
	^ container
]

{ #category : #accessing }
BlDragToSignal >> container: anObject [
	container := anObject
]

{ #category : #accessing }
BlDragToSignal >> offset [
	^ offset
]

{ #category : #accessing }
BlDragToSignal >> offset: anObject [
	offset := anObject
]

{ #category : #accessing }
BlDragToSignal >> position [
	^ position
]

{ #category : #accessing }
BlDragToSignal >> position: anObject [
	position := anObject
]
