"
I represent an SVG elliptical arc path segment.

I store the original endpoint-parameterized SVG arc data. When executed I
convert the arc into one or more cubic Bézier segments, while preserving the
absolute/relative semantics expected by the downstream path builder.
"
Class {
	#name : #BlSvgPathEllipticalArcSegment,
	#superclass : #BlSvgPathSegment,
	#instVars : [
		'radii',
		'xAxisRotation',
		'largeArcFlag',
		'sweepFlag',
		'arcTo'
	],
	#category : #'BlocPac-Geometry-SVG'
}

{ #category : #comparing }
BlSvgPathEllipticalArcSegment >> = anotherObject [
	self == anotherObject ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class) ifFalse: [ ^ false ].

	^ anotherObject isAbsolute = self isAbsolute
		and: [ anotherObject arcTo = self arcTo
		and: [ anotherObject radii = self radii
		and: [ anotherObject xAxisRotation = self xAxisRotation
		and: [ anotherObject largeArcFlag = self largeArcFlag
		and: [ anotherObject sweepFlag = self sweepFlag ] ] ] ] ]
]

{ #category : #accessing }
BlSvgPathEllipticalArcSegment >> arcTo [
	^ arcTo
]

{ #category : #accessing }
BlSvgPathEllipticalArcSegment >> arcTo: aPoint [
	arcTo := aPoint
]

{ #category : #'private - geometry' }
BlSvgPathEllipticalArcSegment >> bezierControlFactorForAngle: aDeltaAngle [
	^ (4.0 / 3.0) * ((aDeltaAngle / 4.0) tan)
]

{ #category : #'private - geometry' }
BlSvgPathEllipticalArcSegment >> centerParametersFrom: aStartPoint to: anEndPoint [
	| rx ry phi cosPhi sinPhi dx2 dy2 x1Prime y1Prime lambda scale rx2 ry2 x1Prime2 y1Prime2 numerator denominator coefficient sign cxPrime cyPrime cx cy theta1 deltaTheta ux uy vx vy |
	rx := self rx abs asFloat.
	ry := self ry abs asFloat.
	phi := self xAxisRotationInRadians.
	cosPhi := phi cos.
	sinPhi := phi sin.
	dx2 := ((aStartPoint x - anEndPoint x) / 2.0) asFloat.
	dy2 := ((aStartPoint y - anEndPoint y) / 2.0) asFloat.
	x1Prime := cosPhi * dx2 + (sinPhi * dy2).
	y1Prime := sinPhi negated * dx2 + (cosPhi * dy2).
	lambda := (x1Prime squared / rx squared + (y1Prime squared / ry squared))
			asFloat.
	lambda > 1.0
		ifTrue: [ scale := lambda sqrt.
			rx := rx * scale.
			ry := ry * scale ].
	rx2 := rx squared.
	ry2 := ry squared.
	x1Prime2 := x1Prime squared.
	y1Prime2 := y1Prime squared.
	numerator := rx2 * ry2 - (rx2 * y1Prime2) - (ry2 * x1Prime2) max: 0.0.
	denominator := rx2 * y1Prime2 + (ry2 * x1Prime2) max: Float machineEpsilon.
	sign := self largeArcFlag = self sweepFlag ifTrue: [ -1.0 ] ifFalse: [ 1.0 ].
	coefficient := sign * (numerator / denominator) sqrt.
	cxPrime := coefficient * (rx * y1Prime / ry).
	cyPrime := coefficient * (ry * x1Prime / rx) negated.
	cx := cosPhi * cxPrime - (sinPhi * cyPrime)
			+ ((aStartPoint x + anEndPoint x) / 2.0).
	cy := sinPhi * cxPrime + (cosPhi * cyPrime)
			+ ((aStartPoint y + anEndPoint y) / 2.0).
	ux := (x1Prime - cxPrime) / rx.
	uy := (y1Prime - cyPrime) / ry.
	vx := (x1Prime negated - cxPrime) / rx.
	vy := (y1Prime negated - cyPrime) / ry.
	theta1 := self
			vectorAngleFromX: 1.0
			y: 0.0
			toX: ux
			y: uy.
	deltaTheta := self
			vectorAngleFromX: ux
			y: uy
			toX: vx
			y: vy.
	(self sweepFlag not and: [ deltaTheta > 0.0 ])
		ifTrue: [ deltaTheta := deltaTheta - (Float pi * 2.0) ].
	(self sweepFlag and: [ deltaTheta < 0.0 ])
		ifTrue: [ deltaTheta := deltaTheta + (Float pi * 2.0) ].
	^ {#center -> (cx @ cy).
		#rx -> rx.
		#ry -> ry.
		#cosPhi -> cosPhi.
		#sinPhi -> sinPhi.
		#theta1 -> theta1.
		#deltaTheta -> deltaTheta} asDictionary
]

{ #category : #'private - geometry' }
BlSvgPathEllipticalArcSegment >> executeBezierApproximationFrom: aStartPoint to: anEndPoint on: aBuilder [
	| parameters center rx ry cosPhi sinPhi theta1 deltaTheta segmentCount angleStep |
	parameters := self centerParametersFrom: aStartPoint to: anEndPoint.
	center := parameters at: #center.
	rx := parameters at: #rx.
	ry := parameters at: #ry.
	cosPhi := parameters at: #cosPhi.
	sinPhi := parameters at: #sinPhi.
	theta1 := parameters at: #theta1.
	deltaTheta := parameters at: #deltaTheta.
	segmentCount := (((deltaTheta abs) / (Float pi / 2.0)) ceiling) max: 1.
	angleStep := deltaTheta / segmentCount.

	1 to: segmentCount do: [ :anIndex |
		| startAngle endAngle alpha p1 p2 c1 c2 startPointAbsolute firstControlPointAbsolute secondControlPointAbsolute endPointAbsolute |
		startAngle := theta1 + ((anIndex - 1) * angleStep).
		endAngle := startAngle + angleStep.
		alpha := self bezierControlFactorForAngle: angleStep.
		p1 := startAngle cos @ startAngle sin.
		p2 := endAngle cos @ endAngle sin.
		c1 := (p1 x - (alpha * startAngle sin)) @ (p1 y + (alpha * startAngle cos)).
		c2 := (p2 x + (alpha * endAngle sin)) @ (p2 y - (alpha * endAngle cos)).
		startPointAbsolute := self
			mapUnitPoint: p1
			center: center
			rx: rx
			ry: ry
			cosPhi: cosPhi
			sinPhi: sinPhi.
		firstControlPointAbsolute := self
			mapUnitPoint: c1
			center: center
			rx: rx
			ry: ry
			cosPhi: cosPhi
			sinPhi: sinPhi.
		secondControlPointAbsolute := self
			mapUnitPoint: c2
			center: center
			rx: rx
			ry: ry
			cosPhi: cosPhi
			sinPhi: sinPhi.
		endPointAbsolute := self
			mapUnitPoint: p2
			center: center
			rx: rx
			ry: ry
			cosPhi: cosPhi
			sinPhi: sinPhi.

		self isAbsolute
			ifTrue: [
				aBuilder
					curveVia: firstControlPointAbsolute
					and: secondControlPointAbsolute
					to: endPointAbsolute ]
			ifFalse: [
				aBuilder
					curveVia: firstControlPointAbsolute - startPointAbsolute
					and: secondControlPointAbsolute - startPointAbsolute
					to: endPointAbsolute - startPointAbsolute ] ]
]

{ #category : #executing }
BlSvgPathEllipticalArcSegment >> executeOn: aBuilder [
	| aStartPoint anEndPoint |
	aStartPoint := aBuilder currentPoint.
	anEndPoint := self isAbsolute
		ifTrue: [ self arcTo ]
		ifFalse: [ aStartPoint + self arcTo ].

	aStartPoint = anEndPoint ifTrue: [ ^ self ].
	((self rx = 0) or: [ self ry = 0 ]) ifTrue: [
		self isAbsolute
			ifTrue: [ aBuilder lineTo: anEndPoint ]
			ifFalse: [ aBuilder lineTo: self arcTo ].
		^ self ].

	self executeBezierApproximationFrom: aStartPoint to: anEndPoint on: aBuilder
]

{ #category : #comparing }
BlSvgPathEllipticalArcSegment >> hash [
	^ self isAbsolute hash
		bitXor: self arcTo hash
		bitXor: self radii hash
		bitXor: self xAxisRotation hash
		bitXor: self largeArcFlag hash
		bitXor: self sweepFlag hash
]

{ #category : #initialization }
BlSvgPathEllipticalArcSegment >> initialize [
	super initialize.
	radii := 0 @ 0.
	xAxisRotation := 0.0.
	largeArcFlag := false.
	sweepFlag := false.
	arcTo := 0 @ 0
]

{ #category : #testing }
BlSvgPathEllipticalArcSegment >> isEllipticalArc [
	^ true
]

{ #category : #accessing }
BlSvgPathEllipticalArcSegment >> largeArcFlag [
	^ largeArcFlag
]

{ #category : #accessing }
BlSvgPathEllipticalArcSegment >> largeArcFlag: aBoolean [
	largeArcFlag := aBoolean
]

{ #category : #'private - geometry' }
BlSvgPathEllipticalArcSegment >> mapUnitPoint: aPoint center: aCenter rx: rx ry: ry cosPhi: cosPhi sinPhi: sinPhi [
	| x y |
	x := rx * aPoint x.
	y := ry * aPoint y.
	^ ((aCenter x + (cosPhi * x) - (sinPhi * y))
		@ (aCenter y + (sinPhi * x) + (cosPhi * y))) asFloatPoint
]

{ #category : #printing }
BlSvgPathEllipticalArcSegment >> printOn: aStream [
	aStream
		nextPutAll: 'Elliptical arc ';
		nextPutAll: self printAbsolute;
		nextPutAll: ' radii ';
		print: self radii;
		nextPutAll: ' rotation ';
		print: self xAxisRotation;
		nextPutAll: ' large: ';
		print: self largeArcFlag;
		nextPutAll: ' sweep: ';
		print: self sweepFlag;
		nextPutAll: ' to ';
		print: self arcTo
]

{ #category : #accessing }
BlSvgPathEllipticalArcSegment >> radii [
	^ radii
]

{ #category : #accessing }
BlSvgPathEllipticalArcSegment >> radii: aPoint [
	radii := aPoint
]

{ #category : #'private - geometry' }
BlSvgPathEllipticalArcSegment >> rx [
	^ self radii x
]

{ #category : #'private - geometry' }
BlSvgPathEllipticalArcSegment >> ry [
	^ self radii y
]

{ #category : #accessing }
BlSvgPathEllipticalArcSegment >> sweepFlag [
	^ sweepFlag
]

{ #category : #accessing }
BlSvgPathEllipticalArcSegment >> sweepFlag: aBoolean [
	sweepFlag := aBoolean
]

{ #category : #'private - geometry' }
BlSvgPathEllipticalArcSegment >> vectorAngleFromX: ux y: uy toX: vx y: vy [
	^ ((ux * vy) - (uy * vx)) arcTan: ((ux * vx) + (uy * vy))
]

{ #category : #accessing }
BlSvgPathEllipticalArcSegment >> xAxisRotation [
	^ xAxisRotation
]

{ #category : #accessing }
BlSvgPathEllipticalArcSegment >> xAxisRotation: aNumber [
	xAxisRotation := aNumber
]

{ #category : #'private - geometry' }
BlSvgPathEllipticalArcSegment >> xAxisRotationInRadians [
	^ self xAxisRotation * Float pi / 180.0
]
