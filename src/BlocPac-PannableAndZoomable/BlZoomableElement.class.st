"
# Zoomable element
Allows users to scale the content of the zoomable element but not the zoomable element itself, in contrast to the {{gtClass:BlPinchableElement}} which scales itself.
The zoomable element's layout constraints are set to fit content, the layout bounds will take the scaling transformation of the content into account.
## Default state
By default, zoomable element matches parent and does not have a fixed zoomLevel, which means that the content element is scaled in such a way that it occupies all available space withing the zoomable element.
The `zoomCenter` is set to 0.5, meaning that the center of the content element matches the center of the zoomable element.
In the example below, the border around the zoomable element indicate its match parent bounds. As you can see, the content is aligned in the center of the zoomable element:
{{gtExample:BlZoomableElementExamples>>#zoomableElementWithContentMatchParentNoUserZoom|previewExpanded=true|codeExpanded=false}}
## Fit content
In graphical frameworks, the element transformations do not normally affect the layout bounds, which allows users to implement some interesting animation effects. However, it is sometimes necessary to make sure that transformation is taken into account. A zoomable element allows us just that when its layout constraints are set to `fitContent`.
In the following example, the zoomable is zoomed out and fits content, notice how the gray border now encompasses the content element, meaning that the transformation is correctly taken into account:
{{gtExample:BlZoomableElementExamples>>#zoomableElementFitContentWithContentZoomedOut|previewExpanded=true|codeExpanded=false}}
## As pannnable element
A zoomable element can be transformed into a {{gtClass:BlPannableElement}} by sending a `convertion` message {{gtMethod:BlZoomableElement>>#asPannableElement}}

"
Class {
	#name : #BlZoomableElement,
	#superclass : #BlElement,
	#instVars : [
		'zoomLevel',
		'zoomCenter',
		'zoomStep',
		'contentElement'
	],
	#category : #'BlocPac-PannableAndZoomable'
}

{ #category : #converting }
BlZoomableElement >> asPannableElement [
	^ BlPannableElement new zoomableElement: self
]

{ #category : #converting }
BlZoomableElement >> asScalableElement [
	^ self
]

{ #category : #initialization }
BlZoomableElement >> computeZoomLevel [
	"Compute zoom level based on the extent of a content element and its scale transformation"
	<return: #Number>

	self hasContentElement
		ifFalse: [ ^ 1 ].

	(self contentElement width isZero or: [ self contentElement height isZero ])
		ifTrue: [ ^ 1 ].

	^ (self contentElement bounds transformed extent / self contentElement extent) min
]

{ #category : #accessing }
BlZoomableElement >> contentElement [
	"Return a content element that is being scaled"
	<return: #BlElement>

	self
		assert: [ contentElement isNotNil ]
		description: [ 'Can not access a content element when it is not provided' ].

	^ contentElement
]

{ #category : #accessing }
BlZoomableElement >> contentElement: anElement [
	"Specify an element that should be scaled according to my size.
	If I already have a content element, it will be replaced with a new one.
	anElement must not be nil."
	self
		assert: [ anElement isNotNil ]
		description: [ 'Content element must not be nil' ].

	self addChild: anElement
]

{ #category : #testing }
BlZoomableElement >> hasContentElement [
	"Return true if I have a content element, false otherwise"
	<return: #Boolean>
	
	^ contentElement isNotNil
]

{ #category : #testing }
BlZoomableElement >> hasZoomLevel [
	"Return true if zoom level is user-defined, otherwise false"
	<return: #Boolean>

	^ zoomLevel isNotNil
]

{ #category : #initialization }
BlZoomableElement >> initialize [
	super initialize.
	
	zoomLevel := nil.
	zoomCenter := 0.5@0.5.
	zoomStep := 0.1.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #layout }
BlZoomableElement >> measureMatching: anExtentMeasurementSpec [
	| widthSpec heightSpec aTransformedBounds |
	
	aTransformedBounds := self contentElement transformation inverseTransformBounds: self measuredBounds bounds.

	widthSpec := self contentElement constraints horizontal resizer isMatchParent
		ifTrue: [ BlMeasurementSpec exact: aTransformedBounds width ]
		ifFalse: [ 
			self layout
				measurementSpecFor: anExtentMeasurementSpec widthSpec
				usedSize: 0.0
				resizer: self contentElement constraints horizontal resizer ].
			
	heightSpec := self contentElement constraints vertical resizer isMatchParent
		ifTrue: [ BlMeasurementSpec exact: aTransformedBounds height ]
		ifFalse: [
			self layout
				measurementSpecFor: anExtentMeasurementSpec heightSpec
				usedSize: 0.0
				resizer: self contentElement constraints vertical resizer ].
			
	self contentElement measure: widthSpec @ heightSpec
]

{ #category : #layout }
BlZoomableElement >> measureScale [
	"Compute and return a scale factor of the content element based on the current scale strategy"
	| aScaleFactor |
	<return: #Number>

	self hasContentElement
		ifFalse: [ 1.0 ].
		
	aScaleFactor := self hasZoomLevel
		ifTrue: [ zoomLevel ]
		ifFalse: [ | aMeasuredExtent |
			aMeasuredExtent := self contentElement measuredExtent.
			(aMeasuredExtent x * aMeasuredExtent y) isZero
				ifTrue: [ 1.0 ]
				ifFalse: [ (self measuredExtent / aMeasuredExtent) min asFloat ] ].
	
	"we must not scale by zero! Otherwise matrix becomes singular"
	aScaleFactor isZero
		ifTrue: [ aScaleFactor := 1.0 ].
		
	^ aScaleFactor
]

{ #category : #'hooks - children' }
BlZoomableElement >> onChildAdded: anElement [
	"I make sure that there is only one child"
	super onChildAdded: anElement.

	"If we already have a content element, we should remove an old one
	in order to replace it with one just provided"
	self hasContentElement
		ifTrue: [ self removeChild: self contentElement ].

	contentElement := anElement
]

{ #category : #layout }
BlZoomableElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	| aContentBounds |

	self hasContentElement
		ifFalse: [ ^ self ].

	aContentBounds := BlBounds origin: 0.0@0.0 extent: self contentElement measuredExtent.
	aContentBounds translateBy: (self measuredExtent - aContentBounds extent) / 2.0.
	aContentBounds translateBy: (self measuredExtent) * ((0.5 asPoint - zoomCenter)) * self zoomLevel.
	aContentBounds translateBy: ((aContentBounds extent - self measuredExtent)) * (0.5 - zoomCenter) * self zoomLevel.
	
	self contentElement applyLayoutIn: aContentBounds context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
BlZoomableElement >> onMeasure: anExtentMeasurementSpec [
	| aScaleFactor aTransformedExtent |
	"First we perform a default measurement"
	super onMeasure: anExtentMeasurementSpec.
	
	self hasContentElement
		ifFalse: [ ^ self ].
	
	"and then we scale a content element according to scaling strategy"
	aScaleFactor := self measureScale.

	self contentElement
		transformDo: [ :t |
			t scaleBy: aScaleFactor asPoint ].

	aTransformedExtent := self contentElement measuredBounds transformed extent.
	self measuredExtent: (anExtentMeasurementSpec sizeFor: aTransformedExtent).

	(self contentElement constraints horizontal resizer isMatchParent
		or: [ self contentElement constraints vertical resizer isMatchParent ] )
			ifTrue: [ self measureMatching: anExtentMeasurementSpec ]
]

{ #category : #accessing }
BlZoomableElement >> zoomCenter [
	<return: #Point>

	^ zoomCenter
]

{ #category : #accessing }
BlZoomableElement >> zoomCenter: aPoint [
	"Zoom center defines a point of the content element which should be in the middle of the zoomable
	element when zoomed in or zoomed out.
	By default the center of the content element matches the center of the zoomable element, hence the zoomCenter is 0.5@0.5"

	zoomCenter := aPoint asPoint.
	self requestLayout
]

{ #category : #zooming }
BlZoomableElement >> zoomIn [
	self zoomLevel: self zoomLevel + self zoomStep
]

{ #category : #accessing }
BlZoomableElement >> zoomLevel [
	<return: #Number>

	^ self hasZoomLevel
		ifTrue: [ zoomLevel ]
		ifFalse: [ self computeZoomLevel ]
]

{ #category : #accessing }
BlZoomableElement >> zoomLevel: aNumber [
	zoomLevel := aNumber max: 0.001.
	self requestLayout
]

{ #category : #zooming }
BlZoomableElement >> zoomOut [
	self zoomLevel: self zoomLevel - self zoomStep
]

{ #category : #accessing }
BlZoomableElement >> zoomStep [
	^ zoomStep
]

{ #category : #accessing }
BlZoomableElement >> zoomStep: aNumber [
	zoomStep := aNumber
]

{ #category : #zooming }
BlZoomableElement >> zoomToActualSize [
	self zoomLevel: 1
]

{ #category : #zooming }
BlZoomableElement >> zoomToFit [
	zoomLevel := nil.
	zoomCenter := 0.5 asPoint.
	self requestLayout
]
