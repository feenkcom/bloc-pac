Class {
	#name : #BlResizerRightListener,
	#superclass : #BlResizerListener,
	#category : #'BlocPac-Resizable'
}

{ #category : #resizer }
BlResizerRightListener >> resizeBounds: aBlBounds by: aPoint [
	aBlBounds extent: ((aBlBounds extent + (aPoint x @ 0)) max: self minimumExtent)
]

{ #category : #resizer }
BlResizerRightListener >> resizerCursor [
	^ BlCursor resizeRight
]
