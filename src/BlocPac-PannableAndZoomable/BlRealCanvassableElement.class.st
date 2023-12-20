Class {
	#name : #BlRealCanvassableElement,
	#superclass : #BlElement,
	#instVars : [
		'cameraPosition',
		'tiledLayer',
		'scaleFactor'
	],
	#category : #'BlocPac-PannableAndZoomable-Core'
}

{ #category : #accessing }
BlRealCanvassableElement >> cameraPosition [
	^ cameraPosition
]

{ #category : #accessing }
BlRealCanvassableElement >> cameraPosition: aPoint [
	cameraPosition := aPoint.
	tiledLayer ifNotNil: [ :aTiledLayer | aTiledLayer viewportCameraPosition: aPoint ].
	self invalidate
]

{ #category : #accessing }
BlRealCanvassableElement >> gtLiveFor: aView [
	^ (super gtLiveFor: aView)
		actionButtonIcon: BrGlamorousVectorIcons add tooltip: 'Zoom in'
			action:  [ self zoomIn ];
		actionButtonIcon: BrGlamorousVectorIcons remove tooltip: 'Zoom out'
			action:  [ self zoomOut ];
		yourself
]

{ #category : #accessing }
BlRealCanvassableElement >> initialize [
	super initialize.

	cameraPosition := 0@0.
	scaleFactor := BlCompositionTileScaleInFactor scale: 1.0.
	
	self preventChildrenMouseEvents.
	
	self
		when: BlMouseWheelEvent
		do: [ :anEvent | 
			anEvent consumed: true.
			self cameraPosition: self cameraPosition + (anEvent vector x @ anEvent vector y negated) ]
]

{ #category : #accessing }
BlRealCanvassableElement >> paintChildrenOn: aCompositorPainter offset: anOffset [	
	
	tiledLayer ifNil: [
		tiledLayer := BlCompositionTiledLayer new
			viewportExtent: self extent;
			viewportCameraPosition: self cameraPosition;
			tileExtent: 128@128.

		self children reverseDo: [ :eachChild |
			tiledLayer addFigure: (BlCompositionTileFigure new
				offset: eachChild position;
				extent: eachChild extent;
				picture: [
					| aRecordingCanvas |
	
					aRecordingCanvas := SkiaCanvas recording: (0@0 extent: eachChild extent).
					aRecordingCanvas transform
						by: [ :t | t translateBy: (eachChild position negated) ]
						during: [ eachChild fullDrawOnSpartaCanvas: aRecordingCanvas. ].
					
					aRecordingCanvas snapshot ]) ] ].
	
	aCompositorPainter
		pushLayer: (BlCompositionOffsetLayer new
			offset: anOffset;
			addLayer: tiledLayer)
		offset: anOffset
		bounds: self invalidationBounds
		compositing: BlCompositingSeparateLayerMode uniqueInstance
		thenPaint: [ :aNewPainter :aNewOffset | ].
]

{ #category : #accessing }
BlRealCanvassableElement >> scaleFactor: aScaleFactor [
	scaleFactor := aScaleFactor.
	tiledLayer ifNotNil: [ :aTiledLayer | aTiledLayer scaleFactor: aScaleFactor ].
	self invalidate
]

{ #category : #accessing }
BlRealCanvassableElement >> zoomIn [
	self scaleFactor: (BlCompositionTileScaleInFactor scale: scaleFactor scale * 1.2)
]

{ #category : #accessing }
BlRealCanvassableElement >> zoomOut [
	self scaleFactor: (BlCompositionTileScaleOutFactor scale: scaleFactor scale / 1.2)
]
