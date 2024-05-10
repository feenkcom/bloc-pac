Class {
	#name : #BlResizerRightListener,
	#superclass : #BlResizerListener,
	#category : #'BlocPac-Resizable'
}

{ #category : #resizer }
BlResizerRightListener >> resizeBounds: aBlBounds by: aPoint [
	| newExtent |
	newExtent := self isKeepRatio
			ifTrue: [ | aNewY |
				aNewY := (aBlBounds width + aPoint x) / aBlBounds width * aBlBounds height.
				(aBlBounds width + aPoint x) @ aNewY ]
			ifFalse: [ aBlBounds extent + (aPoint x @ 0.0) ].
	aBlBounds extent: (newExtent max: self minimumExtent)
]

{ #category : #resizer }
BlResizerRightListener >> resizerCursor [
	^ BlCursor resizeRight
]
