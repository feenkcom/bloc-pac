"
I am sent by an element with applied Resizer Listener after the resizing target was resized

"
Class {
	#name : #BlResizerResizedEvent,
	#superclass : #BlResizerEvent,
	#instVars : [
		'extent'
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
