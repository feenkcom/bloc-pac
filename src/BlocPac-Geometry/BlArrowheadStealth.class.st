Class {
	#name : #BlArrowheadStealth,
	#superclass : #BlArrowheadElement,
	#instVars : [
		'arrowLengthFraction',
		'arrowNoseAngle',
		'arrowShape'
	],
	#category : #'BlocPac-Geometry-Arrowheads'
}

{ #category : #accessing }
BlArrowheadStealth >> arrowLengthFraction [
	<return: #Number>
	
	^ arrowLengthFraction
]

{ #category : #accessing }
BlArrowheadStealth >> arrowLengthFraction: aNumber [
	
	arrowLengthFraction := aNumber.
	self geometryChanged
]

{ #category : #accessing }
BlArrowheadStealth >> arrowNoseAngle [
	<return: #Number>

	^ arrowNoseAngle
]

{ #category : #accessing }
BlArrowheadStealth >> arrowNoseAngle: anAngleInDegrees [

	self
		assert: [ anAngleInDegrees > 0 and: [ anAngleInDegrees < 180 ] ]
		description: [ 'Angle should be within interval [0 ... 180]' ].

	arrowNoseAngle := anAngleInDegrees.
	self geometryChanged
]

{ #category : #initialization }
BlArrowheadStealth >> createShapeForWidth: aNumber [
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
BlArrowheadStealth >> defaultGeometry [
	^ BlPolygon vertices: {
		0@0.
		60@30.
		0@60.
		40@40.
		40@20
	}
]

{ #category : #initialization }
BlArrowheadStealth >> initialize [
	super initialize.

	arrowLengthFraction := 2.5.
	arrowNoseAngle := 45.
	arrowShape := self createShapeForWidth: 1
]

{ #category : #changes }
BlArrowheadStealth >> onWidthChanged: aNumber [
	arrowShape := self createShapeForWidth: aNumber.
	self size: arrowShape boundingBox extent.
	self geometry: (BlShaperGeometry new shape: arrowShape)
]

{ #category : #'geometry hooks' }
BlArrowheadStealth >> updateMargin [
	self margin: (BlInsets right: (arrowShape edgeAt: 5) middle x negated)
]
