Trait {
	#name : #TBlZoomable,
	#instVars : [
		'zoomStep'
	],
	#category : #'BlocPac-PannableAndZoomable-Utiltities'
}

{ #category : #'api - zooming' }
TBlZoomable >> defaultZoomStep [
	^ 0.1
]

{ #category : #'api - zooming' }
TBlZoomable >> zoomIn [
	self zoomLevel: self zoomLevel + self zoomStep
]

{ #category : #'api - zooming' }
TBlZoomable >> zoomLevel [
	^ self explicitRequirement
]

{ #category : #'api - zooming' }
TBlZoomable >> zoomLevel: aNumber [
	self explicitRequirement
]

{ #category : #'api - zooming' }
TBlZoomable >> zoomOut [
	self zoomLevel: self zoomLevel - self zoomStep
]

{ #category : #'api - zooming' }
TBlZoomable >> zoomStep [
	^ zoomStep ifNil: [ zoomStep := self defaultZoomStep ]
]

{ #category : #'api - zooming' }
TBlZoomable >> zoomStep: aNumber [
	zoomStep := aNumber
]

{ #category : #'api - zooming' }
TBlZoomable >> zoomToActualSize [
	self zoomLevel: 1
]

{ #category : #'api - zooming' }
TBlZoomable >> zoomToFit [
	self explicitRequirement
]
