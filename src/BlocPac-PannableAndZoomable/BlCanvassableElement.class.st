Class {
	#name : #BlCanvassableElement,
	#superclass : #BlElement,
	#traits : 'TBlZoomable',
	#classTraits : 'TBlZoomable classTrait',
	#instVars : [
		'childrenTransformation',
		'autoScaleEnabled',
		'childrenScaleFactor',
		'childrenTranslationFactor',
		'automaticScaleFactor',
		'automaticTranslationFactor'
	],
	#category : #'BlocPac-PannableAndZoomable-Core'
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

{ #category : #accessing }
BlCanvassableElement >> childrenScaleFactor [
	^ childrenScaleFactor
]

{ #category : #accessing }
BlCanvassableElement >> childrenScaleFactor: aNumber [
	(childrenScaleFactor closeTo: aNumber)
		ifTrue: [ ^ self ].

	childrenScaleFactor := aNumber max: 0.001.
	self updateChildrenTransformation.
	self dispatchEvent: (BlCanvassableZoomLevelChanged new)
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

{ #category : #accessing }
BlCanvassableElement >> childrenTranslationFactor [
	^ childrenTranslationFactor
]

{ #category : #accessing }
BlCanvassableElement >> childrenTranslationFactor: aPoint [
	(childrenTranslationFactor closeTo: aPoint)
		ifTrue: [ ^ self ].

	childrenTranslationFactor := aPoint.
	self updateChildrenTransformation.
]

{ #category : #'api - zooming' }
BlCanvassableElement >> defaultZoomStep [
	^ 0.2
]

{ #category : #'api - zooming' }
BlCanvassableElement >> disableAutoScale [
	autoScaleEnabled := false.
	self requestLayout
]

{ #category : #'api - zooming' }
BlCanvassableElement >> enableAutoScale [
	autoScaleEnabled := true.
	self requestLayout
]

{ #category : #'gt-extension' }
BlCanvassableElement >> gtLiveFor: aView [
	<gtView>
	^ (super gtLiveFor: aView)
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomin asElement;
				label: 'Zoom In' asRopedText;
				action: [ self zoomIn ] ];
		actionStencil: [ 
			BrButton new 
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons zoomout asElement;
				label: 'Zoom Out' asRopedText;
				action: [ self zoomOut ] ];
		actionStencil: [ 
			BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons actualsize asElement;
				label: 'Resize' asRopedText;
				action: [ self zoomToActualSize ] ]
]

{ #category : #initialization }
BlCanvassableElement >> initialize [
	super initialize.

	childrenTransformation := BlElementIdentityTransformation uniqueInstance asCachedTransformation.

	childrenScaleFactor := 1.
	childrenTranslationFactor := 0@0.
	zoomStep := 0.1.
	automaticScaleFactor := (0@0) -> 1.
	automaticTranslationFactor := 0@0.
	autoScaleEnabled := false.
	
	self addEventHandler: BlCanvassableElementSlideHandler new.
	self beInSeparateCompositionLayer
]

{ #category : #'geometry bounds' }
BlCanvassableElement >> invalidationBounds [
	^ (self invalidationBounds: BlBounds new) asRectangle
]

{ #category : #'geometry bounds' }
BlCanvassableElement >> invalidationBounds: aBounds [
	| anInvalidationBounds |

	anInvalidationBounds := (super invalidationBounds: aBounds).
	anInvalidationBounds merge: (self childrenTransformation inverseTransformBounds: aBounds copy).
	
	^ anInvalidationBounds
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

{ #category : #layout }
BlCanvassableElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	| aMyExtent aChildrenBoundingBox aChildrenExtent aNewScaleFactor |
	super onLayout: aBounds context: aBlElementBoundsUpdateContext.

	aMyExtent := self extent.

	(aMyExtent closeTo: automaticScaleFactor key)
		ifTrue: [ ^ self ].
	
	aChildrenBoundingBox := self children accountedByLayout
		ifEmpty: [ 0@0 extent: 0@0 ]
		ifNotEmpty: [ :theChildren |
			| theBounds |
			theBounds := theChildren first bounds bounds.
			theChildren do: [ :eachChild | theBounds merge: eachChild bounds bounds ].
			theBounds asRectangle ].
	
	aChildrenBoundingBox := self padding expand: aChildrenBoundingBox.
	
	aChildrenExtent := aChildrenBoundingBox extent.
	((aChildrenExtent x closeTo: 0) or: [ (aChildrenExtent y closeTo: 0) ])
		ifTrue: [ ^ self ].

	aNewScaleFactor := (aMyExtent / aChildrenExtent) min.
	automaticScaleFactor := aMyExtent -> aNewScaleFactor.
	automaticTranslationFactor := (aMyExtent / 2.0) - aChildrenBoundingBox center.
	
	self childrenTransformDo: [ :t |
		t
			translateBy: automaticTranslationFactor;
			scaleBy: childrenScaleFactor * automaticScaleFactor value ].
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
BlCanvassableElement >> updateChildrenTransformation [
	self childrenTransformDo: [ :t |
		t
			translateBy: automaticTranslationFactor + childrenTranslationFactor;
			scaleBy: childrenScaleFactor * automaticScaleFactor value ]
]

{ #category : #transformations }
BlCanvassableElement >> updateTransformationBounds [
	"Update the bounds of the cached transformation in order to recompute its matrix
	since transformation origin depends on the element's bounds"
	super updateTransformationBounds.
	
	childrenTransformation bounds: self bounds inLocal asRectangle
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomLevel [
	<return: #Number>

	^ self childrenScaleFactor
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomLevel: aNumber [
	| anAnimation |
	
	anAnimation := BlNumberTransition new
		onStepDo: [ :aScaleFactor | self childrenScaleFactor: aScaleFactor ];
		from: self childrenScaleFactor;
		to: aNumber;
		duration: 250 milliSeconds.

	self addAnimation: anAnimation
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomToFit [
	
]
