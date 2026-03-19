Class {
	#name : #BlSvgPathReflectedCurbicBezierSegment,
	#superclass : #BlSvgPathSegment,
	#instVars : [
		'previousCubicBezierSegment',
		'secondViaPoint',
		'curveTo',
		'lastControlPoint'
	],
	#category : #'BlocPac-Geometry-SVG'
}

{ #category : #comparing }
BlSvgPathReflectedCurbicBezierSegment >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ curveTo = anObject curveTo
		and: [ isAbsolute = anObject isAbsolute
				and: [ previousCubicBezierSegment = anObject previousCubicBezierSegment
						and: [ secondViaPoint = anObject secondViaPoint ] ] ]
]

{ #category : #accessing }
BlSvgPathReflectedCurbicBezierSegment >> curveTo [
	^ curveTo
]

{ #category : #accessing }
BlSvgPathReflectedCurbicBezierSegment >> curveTo: anObject [
	curveTo := anObject
]

{ #category : #executing }
BlSvgPathReflectedCurbicBezierSegment >> executeOn: aBuilder [
	| aFirstViaPoint |
	
	lastControlPoint := self isAbsolute
		ifTrue: [ self secondViaPoint ]
		ifFalse: [ aBuilder currentPoint + self secondViaPoint ].
	
	aFirstViaPoint := self previousCubicBezierSegment
		ifNil: [
			self isAbsolute
				ifTrue: [ aBuilder currentPoint ]
				ifFalse: [ 0@0 ] ]
		ifNotNil: [ :aPreviousCubicBezierSegment |
			| aPreviousRelativeControlPoint |
			
			aPreviousRelativeControlPoint := aBuilder currentPoint - aPreviousCubicBezierSegment lastControlPoint.

			self isAbsolute
				ifTrue: [ aBuilder currentPoint + aPreviousRelativeControlPoint ]
				ifFalse: [ aPreviousRelativeControlPoint ] ].

	aBuilder curveVia: aFirstViaPoint and: self secondViaPoint to: self curveTo
]

{ #category : #comparing }
BlSvgPathReflectedCurbicBezierSegment >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ curveTo hash
		bitXor:
			(isAbsolute hash
				bitXor: (previousCubicBezierSegment hash bitXor: secondViaPoint hash))
]

{ #category : #testing }
BlSvgPathReflectedCurbicBezierSegment >> isCubicBezier [
	^ true
]

{ #category : #accessing }
BlSvgPathReflectedCurbicBezierSegment >> lastControlPoint [
	"Return an absolute position of the second control point. It is used to implement reflected cubic bezier"

	^ lastControlPoint
]

{ #category : #accessing }
BlSvgPathReflectedCurbicBezierSegment >> previousCubicBezierSegment [
	^ previousCubicBezierSegment
]

{ #category : #accessing }
BlSvgPathReflectedCurbicBezierSegment >> previousCubicBezierSegment: anObject [
	previousCubicBezierSegment := anObject
]

{ #category : #printing }
BlSvgPathReflectedCurbicBezierSegment >> printOn: aStream [
	aStream
		nextPutAll: 'Reflected cubic bezier ';
		nextPutAll: self printAbsolute;
		nextPutAll: ' via ';
		print: self secondViaPoint;
		nextPutAll: ' to ';
		print: self curveTo
]

{ #category : #accessing }
BlSvgPathReflectedCurbicBezierSegment >> secondViaPoint [
	^ secondViaPoint
]

{ #category : #accessing }
BlSvgPathReflectedCurbicBezierSegment >> secondViaPoint: anObject [
	secondViaPoint := anObject
]
