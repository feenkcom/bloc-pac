Class {
	#name : #BlCanvassableElement,
	#superclass : #BlElement,
	#instVars : [
		'childrenTransformation',
		'zoomLevel',
		'zoomStep'
	],
	#category : #'BlocPac-PannableAndZoomable'
}

{ #category : #converting }
BlCanvassableElement >> asPannableElement [
	^ self
]

{ #category : #converting }
BlCanvassableElement >> asScalableElement [
	^ self
]

{ #category : #'geometry bounds convertion' }
BlCanvassableElement >> childrenBoundsToLocal: aBounds [
	"In-place transform bounds from my childrens' coordinates to my local coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>

	^ self childrenTransformation transformBounds: aBounds
]

{ #category : #'geometry position convertion' }
BlCanvassableElement >> childrenPointToLocal: aPoint [
	"Transform a given point from the local coordinates of my children to my local coordinates"
	<return: #Point>

	^ self childrenTransformation transformPoint: aPoint
]

{ #category : #transformations }
BlCanvassableElement >> childrenTransform [
	<return: #BlTransformationBuilder>
	
	^ BlTransformationBuilder on: self
]

{ #category : #transformations }
BlCanvassableElement >> childrenTransformDo: aBlock [
	| aTransformationBuilder |

	aTransformationBuilder := self childrenTransform.
	aBlock value: aTransformationBuilder.
	aTransformationBuilder applyOnChildren
]

{ #category : #transformations }
BlCanvassableElement >> childrenTransformation [
	<return: #BlElementTransformation>

	^ childrenTransformation
]

{ #category : #transformations }
BlCanvassableElement >> childrenTransformation: anElementTransformation [
	childrenTransformation := anElementTransformation asCachedTransformation
		bounds: self bounds inLocal asRectangle.

	self layout isInfluencedByTransformation
		ifTrue: [ self requestLayout ].

	self boundsCache invalidateBoundsInSpace.
	self invalidate.

	self onTransformationChanged
]

{ #category : #'gt-extension' }
BlCanvassableElement >> gtLiveFor: aView [
	<gtView>
	^ (super gtLiveFor: aView)
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons zoomin asElement;
				label: 'Zoom In' asRopedText;
				action: [ self zoomIn ] ];
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons zoomout asElement;
				label: 'Zoom Out' asRopedText;
				action: [ self zoomOut ] ];
		actionStencil: [ 
			BrButton new
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons actualsize asElement;
				label: 'Resize' asRopedText;
				action: [ self zoomToActualSize ] ]
]

{ #category : #initialization }
BlCanvassableElement >> initialize [
	super initialize.

	childrenTransformation := BlElementIdentityTransformation uniqueInstance asCachedTransformation.
	
	zoomLevel := 1.
	zoomStep := 0.1
]

{ #category : #'geometry bounds convertion' }
BlCanvassableElement >> localBoundsToChildren: aBounds [
	"In-place transform bounds from my local coordinates to my childrens' coordinates.
	Note, that I do not return a new rectangle and instead mutate provided one,
	so do not forget to send #asRectangle to given mutable rectangle in order to get
	immutable one that can be safely stored as instance variable."
	<return: #BlBounds>

	^ self childrenTransformation inverseTransformBounds: aBounds
]

{ #category : #'geometry position convertion' }
BlCanvassableElement >> localPointToChildren: aPoint [
	"Transform a given point from my local coordinates to the local coordinates of my children."
	<return: #Point>

	^ self childrenTransformation inverseTransformPoint: aPoint
]

{ #category : #drawing }
BlCanvassableElement >> paintChildrenOn: aCompositorPainter offset: anOffset [

	childrenTransformation isIdentity
		ifTrue: [ super paintChildrenOn: aCompositorPainter offset: anOffset ]
		ifFalse: [
			aCompositorPainter
				pushTransform: childrenTransformation matrix
				offset: anOffset
				bounds: self invalidationBounds
				compositing: self compositingMode
				thenPaint: [ :aTransformCompositorPainter :aTransformOffset |
					super paintChildrenOn: aTransformCompositorPainter offset: aTransformOffset ] ]
]

{ #category : #transformations }
BlCanvassableElement >> updateTransformationBounds [
	"Update the bounds of the cached transformation in order to recompute its matrix
	since transformation origin depends on the element's bounds"
	super updateTransformationBounds.
	
	childrenTransformation bounds: self bounds inLocal asRectangle
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomIn [
	self zoomLevel: self zoomLevel + self zoomStep
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomLevel [
	<return: #Number>

	^ zoomLevel
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomLevel: aNumber [
	(zoomLevel closeTo: aNumber)
		ifTrue: [ ^ self ].

	zoomLevel := aNumber max: 0.001.
	self childrenTransformDo: [ :t | t scaleBy: zoomLevel ].
	self dispatchEvent: (BlCanvassableZoomLevelChanged new)
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomOut [
	self zoomLevel: self zoomLevel - self zoomStep
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomStep [
	^ zoomStep
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomToActualSize [
	"I position my content element to the center of the canvas: the offset is the difference between my center and the content's center, minus the content's current position."

	self zoomLevel: 1
]
