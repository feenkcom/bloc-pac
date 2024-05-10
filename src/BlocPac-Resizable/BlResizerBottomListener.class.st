Class {
	#name : #BlResizerBottomListener,
	#superclass : #BlResizerListener,
	#category : #'BlocPac-Resizable'
}

{ #category : #resizer }
BlResizerBottomListener >> resizeBounds: aBlBounds by: aPoint [
	| aNewExtent |
	aNewExtent := self isKeepRatio
			ifTrue: [ | aNewX |
				aNewX := (aBlBounds height + aPoint y) / aBlBounds height * aBlBounds width.
				aNewX @ (aBlBounds height + aPoint y) ]
			ifFalse: [ aBlBounds extent + (0 @ aPoint y) ].

	aBlBounds extent: (aNewExtent max: self minimumExtent)
]

{ #category : #resizer }
BlResizerBottomListener >> resizerCursor [
	^ BlCursor resizeBottom
]
