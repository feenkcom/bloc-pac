"
# Pinchable element
Allows users to scale a pinchable element itself, in contrast to the {{gtClass:BlZoomableElement}} which scales its content.
When zooming in or out, the pinchable element's layout bounds are not affected by the scaling transformation.
## As pannnable element
A zoomable element can be transformed into a {{gtClass:BlPannableElement}} by sending a `convertion` message {{gtMethod:BlZoomableElement>>#asPannableElement}}

"
Class {
	#name : #BlPinchableElement,
	#superclass : #BlElement,
	#instVars : [
		'zoomLevel',
		'zoomStep',
		'contentElement'
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

{ #category : #accessing }
BlPinchableElement >> contentElement [
	"Return a content element that is being scaled"
	<return: #BlElement>

	self
		assert: [ contentElement isNotNil ]
		description: [ 'Can not access a content element when it is not provided' ].

	^ contentElement
]

{ #category : #accessing }
BlPinchableElement >> contentElement: anElement [
	"Specify an element that should be scaled according to my size.
	If I already have a content element, it will be replaced with a new one.
	anElement must not be nil."
	self
		assert: [ anElement isNotNil ]
		description: [ 'Content element must not be nil' ].

	self addChild: anElement
]

{ #category : #testing }
BlPinchableElement >> hasContentElement [
	"Return true if I have a content element, false otherwise"
	<return: #Boolean>
	
	^ contentElement isNotNil
]

{ #category : #initialization }
BlPinchableElement >> initialize [
	super initialize.
	
	zoomLevel := 1.
	zoomStep := 0.1.

	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #'hooks - children' }
BlPinchableElement >> onChildAdded: anElement [
	"I make sure that there is only one child"
	super onChildAdded: anElement.

	"If we already have a content element, we should remove an old one
	in order to replace it with one just provided"
	self hasContentElement
		ifTrue: [ self removeChild: self contentElement ].

	contentElement := anElement
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
	self transformDo: [ :t | t scaleBy: zoomLevel ].
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
	"I position my content element to the center of the canvas: the offset is the difference between my center and the content's center, minus the content's current position."

	self zoomLevel: 1.
	self
		relocate:
			(self transformation
				transformPoint:
					(self extent - self contentElement extent) / 2
						- self contentElement bounds inParent position)
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
