Class {
	#name : #BlRealCanvassableElement,
	#superclass : #BlElement,
	#instVars : [
		'cameraPosition'
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
	self invalidate
]

{ #category : #accessing }
BlRealCanvassableElement >> initialize [
	super initialize.

	cameraPosition := 0@0.
	
	self preventChildrenMouseEvents.
	
	self
		when: BlMouseWheelEvent
		do: [ :anEvent | 
			anEvent consumed: true.
			self cameraPosition: self cameraPosition + (anEvent vector x @ anEvent vector y negated) ]
]

{ #category : #accessing }
BlRealCanvassableElement >> paintChildrenOn: aCompositorPainter offset: anOffset [
	| aTiledLayer |
	
	aTiledLayer := BlCompositionTiledLayer new
		viewportExtent: self extent;
		viewportCameraPosition: self cameraPosition;
		tileExtent: 128@128.

	self children reverseDo: [ :eachChild |
	
		aTiledLayer addFigure: (BlCompositionTileFigure new
			offset: eachChild position;
			extent: eachChild extent;
			picture: [
				| aRecordingCanvas |

				aRecordingCanvas := SkiaCanvas recording: eachChild invalidationBounds.
				eachChild fullDrawOnSpartaCanvas: aRecordingCanvas.
				aRecordingCanvas snapshot ]) ].

	aCompositorPainter canvas transform
		by: [ :t | t translateBy: anOffset ]
		during: [
			aTiledLayer
				drawPreviewOn: aCompositorPainter canvas
				element: self ].

	aCompositorPainter
		pushLayer: (BlCompositionOffsetLayer new
			offset: anOffset;
			addLayer: aTiledLayer)
		offset: anOffset
		bounds: self invalidationBounds
		compositing: BlCompositingSeparateLayerMode uniqueInstance
		thenPaint: [ :aNewPainter :aNewOffset | ].
]
