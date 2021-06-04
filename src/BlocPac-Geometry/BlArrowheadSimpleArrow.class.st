"
I am a simple arrow-like arrowhead.
Both my size and arrow length depend on the curve width.

It is possible hovewer to customize a length fraction - how long should be the outer ""arrow"" compared to the length of the side of a nose triangle.

Users can also customise nose angle that tells how wide should the arrow lines be spread.
The with of the outer arrows can be specified by changing border width of a simple arrow arrowhead.

I support both background and border paint and can have hollow inner triangle.

"
Class {
	#name : #BlArrowheadSimpleArrow,
	#superclass : #BlArrowheadElement,
	#instVars : [
		'arrowLengthFraction',
		'arrowNoseAngle',
		'arrowShape'
	],
	#category : #'BlocPac-Geometry-Arrowheads'
}

{ #category : #accessing }
BlArrowheadSimpleArrow >> arrowLengthFraction [
	<return: #Number>
	
	^ arrowLengthFraction
]

{ #category : #accessing }
BlArrowheadSimpleArrow >> arrowLengthFraction: aNumber [
	
	arrowLengthFraction := aNumber.
	self geometryChanged
]

{ #category : #accessing }
BlArrowheadSimpleArrow >> arrowNoseAngle [
	<return: #Number>

	^ arrowNoseAngle
]

{ #category : #accessing }
BlArrowheadSimpleArrow >> arrowNoseAngle: anAngleInDegrees [

	self
		assert: [ anAngleInDegrees > 0 and: [ anAngleInDegrees < 180 ] ]
		description: [ 'Angle should be within interval [0 ... 180]' ].

	arrowNoseAngle := anAngleInDegrees.
	self geometryChanged
]

{ #category : #initialization }
BlArrowheadSimpleArrow >> createShapeForWidth: aNumber [
	| wingAngle aShape |

	wingAngle := 180 - ((540 - 180 - arrowNoseAngle) / 2.0).

	aShape := BlShaperPolygon rectangle: (0@0 extent: aNumber @ (aNumber * 3)).
	(aShape edgeAt: 2) collapse.
	(aShape edgeAt: 3) injectLineAt: 0.5 length: aNumber.
	(aShape edgeAt: 3) counterClockwiseRotateAroundEndBy: wingAngle.
	(aShape edgeAt: 5) clockwiseRotateAroundStartBy: wingAngle.
	(aShape edgeAt: 1) toVertex moveToBuildAngle: arrowNoseAngle.

	"top wing"
	(aShape edgeAt: 5) fromVertex divide.
	(aShape edgeAt: 6) moveAlongNormalBy: (arrowLengthFraction * aNumber) negated.

	"bottom wing"
	(aShape edgeAt: 3) toVertex divide.
	(aShape edgeAt: 3) moveAlongNormalBy: (arrowLengthFraction * aNumber) negated.
	
	aShape moveBy: aShape boundingBox origin negated.
	
	^ aShape
]

{ #category : #initialization }
BlArrowheadSimpleArrow >> defaultGeometry [
	^ BlPolygon vertices: {
		0@0.
		60@30.
		0@60.
		40@40.
		40@20
	}
]

{ #category : #initialization }
BlArrowheadSimpleArrow >> initialize [
	super initialize.

	arrowLengthFraction := 2.5.
	arrowNoseAngle := 45.
	arrowShape := self createShapeForWidth: 1
]

{ #category : #changes }
BlArrowheadSimpleArrow >> onWidthChanged: aNumber [
	arrowShape := self createShapeForWidth: aNumber.
	self size: arrowShape boundingBox extent.
	self geometry: (BlShaperGeometry new shape: arrowShape)
]

{ #category : #'geometry hooks' }
BlArrowheadSimpleArrow >> updateMargin [
	self margin: (BlInsets right: (arrowShape edgeAt: 5) middle x negated)
]
