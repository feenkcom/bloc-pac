Class {
	#name : #BlResizerTopListener,
	#superclass : #BlResizerListener,
	#category : #'BlocPac-Resizable'
}

{ #category : #resizer }
BlResizerTopListener >> resizeBounds: aBlBounds by: aPoint [
	| newExtent |
	newExtent := self isKeepRatio
			ifTrue: [ | aNewX |
				aNewX := (aBlBounds height + aPoint y negated) / aBlBounds height
						* aBlBounds width.
				aNewX @ (aBlBounds height + aPoint y negated) ]
			ifFalse: [ aBlBounds extent + (0 @ aPoint y negated) ].

	newExtent := newExtent max: self minimumExtent.

	aBlBounds
		origin: aBlBounds position + (aBlBounds extent - newExtent)
		extent: newExtent
]

{ #category : #resizer }
BlResizerTopListener >> resizerCursor [
	^ BlCursor resizeTop
]
