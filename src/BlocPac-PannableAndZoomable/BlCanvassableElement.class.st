"
I offer a replacement for compositions of {{gtClass:name=BlPannableElement}} and {{gtClass:name=BlZoomableElement}} by supporting both panning and zooming.

I also support auto-scaling via `enableAutoScale`. Auto-scaling is turned on by the *Zoom to fit* action, and turned off by any other zooming or panning action.

Examples and demos are in {{gtClass:name=BlCanvassableElementExamples}}
"
Class {
	#name : #BlCanvassableElement,
	#superclass : #BlElement,
	#traits : 'TBlZoomable + TBlWithChildrenTransformation',
	#classTraits : 'TBlZoomable classTrait + TBlWithChildrenTransformation classTrait',
	#instVars : [
		'autoScaleEnabled',
		'childrenTransformationOrigin',
		'childrenScaleFactor',
		'childrenTranslationFactor',
		'shouldTranslateOnMouseWheelZoom'
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

{ #category : #'api - zooming' }
BlCanvassableElement >> calculateTranslationFactorOnMouseWheelZoom: anEvent [
	| localPosition translateScalingFactor translateX translateY |
	translateScalingFactor := 1 / 2.
	localPosition := self globalPointToLocal: anEvent position.
	translateX := (self extent x / 2 - localPosition x) * translateScalingFactor.
	translateY := (self extent y / 2 - localPosition y) * translateScalingFactor.
	^ self childrenTranslationFactor + (translateX @ translateY)
]

{ #category : #accessing }
BlCanvassableElement >> childrenBoundingBox [
	| aChildrenBoundingBox |
	aChildrenBoundingBox := self children accountedByLayout
			ifEmpty: [ 0 @ 0 extent: 0 @ 0 ]
			ifNotEmpty: [ :theChildren | 
				| theBounds |
				theBounds := theChildren first bounds bounds.
				theChildren do: [ :eachChild | theBounds merge: eachChild bounds bounds ].
				theBounds asRectangle ].
	aChildrenBoundingBox := self padding expand: aChildrenBoundingBox.
	^ aChildrenBoundingBox
]

{ #category : #accessing }
BlCanvassableElement >> childrenScaleFactor [
	<return: #Number>

	^ childrenScaleFactor
]

{ #category : #'api - zooming' }
BlCanvassableElement >> childrenScaleFactor: aNumber [
	"Change a scale factor of the children transformation and recompute transformation matrix.
	
	Performance notes:
	 - Since we assume that children' position and extent don't depend on the transformation matrix,
	there is no need to request layout recomputation.
	 - If a fraction part of the new scale factor is small, we round down it down to get integer scale.
	
	Usage:
	 - #childrenScaleFactor: can be used within animations to implement a smooth zooming behavior."
	| aNewScaleFactor |
	
	aNewScaleFactor := aNumber asFloat.
	(aNewScaleFactor fractionPart abs <= 0.01)
		ifTrue: [ aNewScaleFactor := aNewScaleFactor rounded ].
		
	(childrenScaleFactor closeTo: aNewScaleFactor)
		ifTrue: [ ^ self ].
		
	aNewScaleFactor < self minChildrenScaleFactor
		ifTrue: [ ^ self ].
	
	childrenScaleFactor := aNewScaleFactor.
	self updateChildrenTransformation.
]

{ #category : #accessing }
BlCanvassableElement >> childrenTranslationFactor [
	<return: #Point>
	
	^ childrenTranslationFactor
]

{ #category : #accessing }
BlCanvassableElement >> childrenTranslationFactor: aPoint [
	childrenTranslationFactor := aPoint.
	self updateChildrenTransformation.
]

{ #category : #'api - zooming' }
BlCanvassableElement >> defaultZoomStep [
	^ 1.2
]

{ #category : #'api - zooming' }
BlCanvassableElement >> disableAutoScale [
	autoScaleEnabled := false.
	self requestLayout
]

{ #category : #'api - zooming' }
BlCanvassableElement >> enableAutoScale [
	"Automatically calculate a scale factor and translate children to center them within a viewport of the canvassable element. When enabled, auto-scale overtakes control of the zooming and positioning logic.
	
	Auto-scale will be automatically disabled as soon as users manually change a zoom factor or drag a content of the canvas."
	
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
				icon: BrGlamorousIcons zoomtofit asElement;
				label: 'Zoom to fit' asRopedText;
				action: [ self zoomToFit ] ];
		actionStencil: [ 
			BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousIcons actualsize asElement;
				label: 'Zoom to actual size' asRopedText;
				action: [ self zoomToActualSize ] ]
]

{ #category : #initialization }
BlCanvassableElement >> initialize [
	super initialize.

	zoomStep := self defaultZoomStep.
	autoScaleEnabled := true.
	
	childrenScaleFactor := 1.
	childrenTranslationFactor := 0@0.
	childrenTransformationOrigin := 0@0.
	
	self addEventHandler: BlCanvassableElementSlideHandler new.
	self beInSeparateCompositionLayer.
	self withZoomOnScrollWheel.
]

{ #category : #'api - zooming' }
BlCanvassableElement >> minChildrenScaleFactor [
	^ 0.014
]

{ #category : #layout }
BlCanvassableElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	"Layout algorithm inputs:
	 - autoScaleEnabled
	 
	 - children scale factor (if auto scale is disabled)
	 - children translation factor (if auto scale is disabled)
	 
	 output:
	 - children scale factor (if auto scale is enabled)
	 - children translation factor (if auto scale is enabled)"
	 
	super onLayout: aBounds context: aBlElementBoundsUpdateContext.

	self autoScaleEnabled
		ifTrue: [ ^ self scaleChildrenToFitContentDuringLayout ]
]

{ #category : #layout }
BlCanvassableElement >> scaleChildrenToFitContentDuringLayout [
	"Must only be used during a layout phase"
	| aMyExtent aChildrenBoundingBox aNewScaleFactor aChildrenExtent |
	
	aMyExtent := self extent.
	aChildrenBoundingBox := self childrenBoundingBox.
	aChildrenExtent := aChildrenBoundingBox extent.
	
	((aMyExtent x closeTo: 0) or: [ aMyExtent y closeTo: 0 ])
		ifTrue: [ ^ self ].
	
	((aChildrenExtent x closeTo: 0) or: [ aChildrenExtent y closeTo: 0 ])
		ifTrue: [ ^ self ].

	aNewScaleFactor := (aMyExtent / aChildrenExtent) min.
	self
		assert: [ (aNewScaleFactor closeTo: 0) not ]
		description: [ 'Scale factor must not be zero' ].
	
	childrenScaleFactor := aNewScaleFactor.
	childrenTransformationOrigin := (self extent / 2.0).
	childrenTranslationFactor := (self extent / 2.0) - (aChildrenBoundingBox center).
	
	self updateChildrenTransformation
]

{ #category : #accessing }
BlCanvassableElement >> shouldTranslateOnMouseWheelZoom [
	^ shouldTranslateOnMouseWheelZoom
		ifNil: [ shouldTranslateOnMouseWheelZoom := true ]
]

{ #category : #accessing }
BlCanvassableElement >> shouldTranslateOnMouseWheelZoom: aBoolean [
	shouldTranslateOnMouseWheelZoom := aBoolean
]

{ #category : #'api - transformation' }
BlCanvassableElement >> translate: aPoint [
	"Animate a change to translation"
	| translateAnimation  |
	
	childrenTransformationOrigin := self extent / 2.0.
	
	"self disableAutoScale."
	
	translateAnimation := BlNumberTransition new
		onStepDo: [ :aTranslateFactor | self childrenTranslationFactor: aTranslateFactor ];
		from: self childrenTranslationFactor;
		to: self childrenTranslationFactor + aPoint;
		duration: 250 milliSeconds.
	
	self addAnimation: translateAnimation
]

{ #category : #transformations }
BlCanvassableElement >> updateChildrenTransformation [
	self
		childrenTransformDo: [ :t |
			t
				origin: (BlAffineTransformationPositionOrigin new position: childrenTransformationOrigin);
				translateBy: childrenTranslationFactor;
				scaleBy: childrenScaleFactor ]
]

{ #category : #'api - zooming' }
BlCanvassableElement >> withZoomOnScrollWheel [
	self
		when: BlMouseWheelEvent
		do: [ :anEvent | 
			(self shouldTranslateOnMouseWheelZoom and: [ anEvent isPrimarilyVertical ])
				ifTrue: [ anEvent modifiers = BlKeyModifiers primary
						ifTrue: [ | eventYvector newZoomLevel scalingFactor |
							anEvent consumed: true.
							eventYvector := anEvent vector y.
							scalingFactor := 1 / 2.
							eventYvector positive
								ifTrue: [ newZoomLevel := self zoomLevel * scalingFactor reciprocal round: 2.
									self zoomLevel: newZoomLevel withTranslate: anEvent ]
								ifFalse: [ newZoomLevel := self zoomLevel * scalingFactor round: 2.
									self zoomLevel: newZoomLevel ] ].

					anEvent modifiers = BlKeyModifiers alt
						ifTrue: [ | eventYvector |
							anEvent consumed: true.
							eventYvector := anEvent vector y.
							eventYvector positive
								ifTrue: [ self translate: (anEvent currentTarget topMostParent extent x / 10) @ 0 ]
								ifFalse: [ self
										translate: (anEvent currentTarget topMostParent extent x / 10) negated @ 0 ] ].

					anEvent modifiers = BlKeyModifiers new
						ifTrue: [ | eventYvector |
							anEvent consumed: true.
							eventYvector := anEvent vector y.
							eventYvector positive
								ifTrue: [ self translate: 0 @ (anEvent currentTarget topMostParent extent x / 10) ]
								ifFalse: [ self
										translate: 0 @ (anEvent currentTarget topMostParent extent x / 10) negated ] ] ] ]
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomIn [
	self zoomLevel: self zoomLevel * self zoomStep
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomLevel [
	<return: #Number>

	^ self childrenScaleFactor
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomLevel: aNumber [
	"Animate a change to zoom level"
	| anAnimation |
	
	childrenTransformationOrigin := self extent / 2.0.
	
	self disableAutoScale.
	
	anAnimation := BlNumberTransition new
		onStepDo: [ :aScaleFactor | self childrenScaleFactor: aScaleFactor ];
		from: self childrenScaleFactor;
		to: aNumber;
		duration: 250 milliSeconds.

	self addAnimation: anAnimation
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomLevel: aNumber withTranslate: anEvent [
	"Animate a change to zoom level while translating to a new position"
	| translateAnimation zoomAnimation |
	
	childrenTransformationOrigin := self extent / 2.0.
	
	self disableAutoScale.
	
	translateAnimation := BlNumberTransition new
		onStepDo: [ :aTranslateFactor | childrenTranslationFactor := aTranslateFactor ];
		from: self childrenTranslationFactor;
		to: (self calculateTranslationFactorOnMouseWheelZoom: anEvent);
		duration: 250 milliSeconds.
	
	zoomAnimation := BlNumberTransition new
		onStepDo: [ :aScaleFactor | self childrenScaleFactor: aScaleFactor ];
		from: self childrenScaleFactor;
		to: aNumber;
		duration: 250 milliSeconds.

	self addAnimation: (BlParallelAnimation with: {translateAnimation. zoomAnimation})
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomOut [
	self zoomLevel: self zoomLevel / self zoomStep
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomToActualSize [
	self zoomLevel: 1
]

{ #category : #'api - zooming' }
BlCanvassableElement >> zoomToFit [
	self enableAutoScale
]
