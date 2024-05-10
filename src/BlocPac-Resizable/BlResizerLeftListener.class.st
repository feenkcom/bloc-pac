Class {
	#name : #BlResizerLeftListener,
	#superclass : #BlResizerListener,
	#category : #'BlocPac-Resizable'
}

{ #category : #resizer }
BlResizerLeftListener >> resizeBounds: aBlBounds by: aPoint [
	| newExtent |
	newExtent := self isKeepRatio
			ifTrue: [ | newY |
				newY := (aBlBounds width + aPoint x negated) / aBlBounds width * aBlBounds height.
				(aBlBounds width + aPoint x negated) @ newY ]
			ifFalse: [ aBlBounds extent + (aPoint negated x @ 0.0)
					max: self minimumExtent ].

	newExtent := newExtent max: self minimumExtent.

	aBlBounds
		origin: aBlBounds position + (aBlBounds extent - newExtent)
		extent: newExtent
]

{ #category : #resizer }
BlResizerLeftListener >> resizerCursor [
	^ BlCursor resizeLeft
]
