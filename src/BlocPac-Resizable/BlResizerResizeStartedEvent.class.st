Class {
	#name : #BlResizerResizeStartedEvent,
	#superclass : #BlResizerEvent,
	#instVars : [
		'originalExtent'
	],
	#category : #'BlocPac-Resizable'
}

{ #category : #accessing }
BlResizerResizeStartedEvent >> originalExtent [
	^ originalExtent
]

{ #category : #'dnd handlers' }
BlResizerResizeStartedEvent >> originalExtent: anExtent [
	 originalExtent := anExtent
]
