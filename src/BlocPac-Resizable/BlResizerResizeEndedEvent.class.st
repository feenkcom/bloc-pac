Class {
	#name : #BlResizerResizeEndedEvent,
	#superclass : #BlResizerEvent,
	#instVars : [
		'modifiedExtent',
		'originalExtent'
	],
	#category : #'BlocPac-Resizable'
}

{ #category : #testing }
BlResizerResizeEndedEvent >> hasVerticalChange [
	^ self originalExtent y ~= self modifiedExtent y
]

{ #category : #accessing }
BlResizerResizeEndedEvent >> modifiedExtent [
	^ modifiedExtent
]

{ #category : #accessing }
BlResizerResizeEndedEvent >> modifiedExtent: anExtent [ 
	modifiedExtent := anExtent 
]

{ #category : #accessing }
BlResizerResizeEndedEvent >> originalExtent [
	^ originalExtent
]

{ #category : #accessing }
BlResizerResizeEndedEvent >> originalExtent: anExtent [ 
	originalExtent := anExtent 
]
