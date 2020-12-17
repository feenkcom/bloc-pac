Class {
	#name : #BlResizerTopLeftListener,
	#superclass : #BlResizerListener,
	#category : #'BlocPac-Resizable'
}

{ #category : #resizer }
BlResizerTopLeftListener >> resizeBounds: aBlBounds by: aPoint [
	| newExtent |
	
	newExtent := (aBlBounds extent + aPoint negated) max: self minimumExtent.

	aBlBounds
		origin: aBlBounds position + (aBlBounds extent - newExtent)
		extent: newExtent
]

{ #category : #resizer }
BlResizerTopLeftListener >> resizerCursor [
	^ BlCursor resizeTopLeft
]
