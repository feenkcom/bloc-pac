"
! Line

Draw a line from the current point to the given (x,y) coordinate which becomes the new current point. L (uppercase) indicates that absolute coordinates will follow; l (lowercase) indicates that relative coordinates will follow. A number of coordinates pairs may be specified to draw a polyline. At the end of the command, the new current point is set to the final set of coordinates provided.
"
Class {
	#name : #BlSvgPathLineSegment,
	#superclass : #BlSvgPathSegment,
	#instVars : [
		'lineTo'
	],
	#category : #'BlocPac-Geometry-SVG'
}

{ #category : #comparing }
BlSvgPathLineSegment >> = anotherObject [

	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].

	^ anotherObject isAbsolute = self isAbsolute
		and: [ anotherObject lineTo = self lineTo ]
]

{ #category : #executing }
BlSvgPathLineSegment >> executeOn: aBuilder [
	aBuilder lineTo: self lineTo
]

{ #category : #comparing }
BlSvgPathLineSegment >> hash [
	^ self isAbsolute hash bitXor: self lineTo hash
]

{ #category : #initialization }
BlSvgPathLineSegment >> initialize [
	super initialize.
	
	lineTo := 0@0
]

{ #category : #accessing }
BlSvgPathLineSegment >> lineTo [
	<return: #Point>

	^ lineTo
]

{ #category : #accessing }
BlSvgPathLineSegment >> lineTo: aPoint [
	lineTo := aPoint
]

{ #category : #printing }
BlSvgPathLineSegment >> printOn: aStream [
	aStream
		nextPutAll: 'Line ';
		nextPutAll: self printAbsolute;
		nextPutAll: ' to ';
		print: self lineTo
]
