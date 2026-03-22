"
I am sent by an element with applied Resizer Listener after the resizing target was resized

"
Class {
	#name : #BlResizerResizedEvent,
	#superclass : #BlResizerEvent,
	#instVars : [
		'extent',
		'resizeTarget',
		'originalExtent'
	],
	#category : #'BlocPac-Resizable'
}

{ #category : #accessing }
BlResizerResizedEvent >> extent [
	^ extent
]

{ #category : #accessing }
BlResizerResizedEvent >> extent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
BlResizerResizedEvent >> originalExtent [
	^ originalExtent
]

{ #category : #accessing }
BlResizerResizedEvent >> originalExtent: aPoint [
	originalExtent := aPoint
]

{ #category : #accessing }
BlResizerResizedEvent >> resizeTarget [
	^ resizeTarget
]

{ #category : #accessing }
BlResizerResizedEvent >> resizeTarget: anObject [
	resizeTarget := anObject
]
