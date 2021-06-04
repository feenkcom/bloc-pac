"
# Horizontal line

Draws a horizontal line from the current point (cpx, cpy) to (x, cpy). H (uppercase) indicates that absolute coordinates will follow; h (lowercase) indicates that relative coordinates will follow. Multiple x values can be provided (although usually this doesn't make sense). At the end of the command, the new current point becomes (x, cpy) for the final value of x.

"
Class {
	#name : #BlSvgPathHorizontalLineSegment,
	#superclass : #BlSvgPathSegment,
	#instVars : [
		'lineX'
	],
	#category : #'BlocPac-Geometry-SVG'
}

{ #category : #comparing }
BlSvgPathHorizontalLineSegment >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ lineX = anObject lineX and: [ isAbsolute = anObject isAbsolute ]
]

{ #category : #executing }
BlSvgPathHorizontalLineSegment >> executeOn: aBuilder [
	self isAbsolute
		ifTrue: [ aBuilder lineTo: self lineX @ aBuilder currentPoint y ]
		ifFalse: [ aBuilder lineTo: self lineX @ 0 ]
]

{ #category : #comparing }
BlSvgPathHorizontalLineSegment >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ lineX hash bitXor: isAbsolute hash
]

{ #category : #initialization }
BlSvgPathHorizontalLineSegment >> initialize [
	super initialize.
	
	lineX := 0
]

{ #category : #accessing }
BlSvgPathHorizontalLineSegment >> lineX [
	^ lineX
]

{ #category : #accessing }
BlSvgPathHorizontalLineSegment >> lineX: anObject [
	lineX := anObject
]

{ #category : #printing }
BlSvgPathHorizontalLineSegment >> printOn: aStream [
	aStream
		nextPutAll: 'Horizontal line ';
		nextPutAll: self printAbsolute;
		nextPutAll: ' to ';
		printOn: self lineX
]
