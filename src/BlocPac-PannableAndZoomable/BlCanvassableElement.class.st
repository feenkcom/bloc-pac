Class {
	#name : #BlCanvassableElement,
	#superclass : #BlElement,
	#traits : 'TBlZoomable + TBlWithChildrenTransformation',
	#classTraits : 'TBlZoomable classTrait + TBlWithChildrenTransformation classTrait',
	#instVars : [
		'autoScaleEnabled',
		'childrenScaleFactor',
		'childrenTranslationFactor',
		'automaticScaleFactor',
		'automaticTranslationFactor'
	],
	#category : #'BlocPac-PannableAndZoomable-Core'
}

{ #category : #converting }
BlCanvassableElement >> asCanvassableElement [
	^ self
]

{ #category : #converting }
BlCanvassableElement >> asPannableElement [
	^ self
]

{ #category : #converting }
BlCanvassableElement >> asScalableElement [
	^ self
]

{ #category : #accessing }
BlCanvassableElement >> autoScaleEnabled [
	^ autoScaleEnabled
]

{ #category : #accessing }
BlCanvassableElement >> automaticScaleFactor [
	^ automaticScaleFactor
]

{ #category : #accessing }
BlCanvassableElement >> automaticTranslationFactor [
	^ automaticTranslationFactor
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

	childrenScaleFactor := 1.
	childrenTranslationFactor := 0@0.
	zoomStep := 0.1.
	automaticScaleFactor := (0@0) -> 1.
	automaticTranslationFactor := 0@0.
	autoScaleEnabled := false.
	
	self addEventHandler: BlCanvassableElementSlideHandler new.
	self beInSeparateCompositionLayer
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

{ #category : #transformations }
BlCanvassableElement >> updateChildrenTransformation [
	self childrenTransformDo: [ :t |
		t
			translateBy: automaticTranslationFactor + childrenTranslationFactor;
			scaleBy: childrenScaleFactor * automaticScaleFactor value ]
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
