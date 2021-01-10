"
! Pinchable element
Allows users to scale a pinchable element itself, in contrast to the ${class:BlZoomableElement}$ which scales its content.
When zooming in or out, the pinchable element's layout bounds are not affected by the scaling transformation.
!! As pannnable element
A zoomable element can be transformed into a ${class:BlPannableElement}$ by sending a ==convertion== message ${method:BlZoomableElement>>#asPannableElement}$
"
Class {
	#name : #BlPinchableElement,
	#superclass : #BlElement,
	#instVars : [
		'zoomLevel',
		'zoomStep'
	],
	#category : #'BlocPac-PannableAndZoomable'
}

{ #category : #converting }
BlPinchableElement >> asPannableElement [
	^ BlPannableElement new zoomableElement: self
]

{ #category : #converting }
BlPinchableElement >> asScalableElement [
	^ self
]

{ #category : #initialization }
BlPinchableElement >> initialize [
	super initialize.
	
	zoomLevel := 1.
	zoomStep := 0.1.
	
	self clipChildren: false
]

{ #category : #'api - zooming' }
BlPinchableElement >> zoomIn [
	self zoomLevel: self zoomLevel + self zoomStep
]

{ #category : #accessing }
BlPinchableElement >> zoomLevel [
	<return: #Number>

	^ zoomLevel
]

{ #category : #accessing }
BlPinchableElement >> zoomLevel: aNumber [
	zoomLevel := aNumber max: 0.001.
	self transformDo: [ :t | t scaleBy: zoomLevel ]
]

{ #category : #'api - zooming' }
BlPinchableElement >> zoomOut [
	self zoomLevel: self zoomLevel - self zoomStep
]

{ #category : #accessing }
BlPinchableElement >> zoomStep [
	^ zoomStep
]

{ #category : #accessing }
BlPinchableElement >> zoomStep: aNumber [
	zoomStep := aNumber
]

{ #category : #'api - zooming' }
BlPinchableElement >> zoomToActualSize [
	self zoomLevel: 1
]

{ #category : #'api - zooming' }
BlPinchableElement >> zoomToFit [
	| aContentElement aContentExtent |
	
	self children isEmpty
		ifTrue: [ ^ self zoomToActualSize ].
	
	aContentElement := self children first.
	aContentExtent := aContentElement extent.
	(aContentExtent x isZero or: [ aContentExtent y isZero ])
		ifTrue: [ ^ self zoomToActualSize ].

	self zoomLevel: (self extent / aContentElement extent) min.
	self relocate: (self transformation transformPoint: (aContentElement bounds inParent position)) negated
]
