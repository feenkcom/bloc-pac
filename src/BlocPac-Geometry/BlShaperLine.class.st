Class {
	#name : #BlShaperLine,
	#superclass : #Object,
	#traits : 'TBlShaperEdge + TBlShaperMovable',
	#classTraits : 'TBlShaperEdge classTrait + TBlShaperMovable classTrait',
	#instVars : [
		'fromVertex',
		'toVertex',
		'figure'
	],
	#category : 'BlocPac-Geometry-Shaper'
}

{ #category : #'api - shape' }
BlShaperLine >> appendPathTo: aPathBuilder [
	(aPathBuilder currentPoint closeTo: self fromVertex point)
		ifFalse: [ aPathBuilder moveTo: self fromVertex point ].

	aPathBuilder lineTo: self toVertex point
]

{ #category : #'api - transformations' }
BlShaperLine >> clockwiseRotateAroundEndBy: anAngleDegrees [
	"rotate the line clockwise around an end vertex by the given amount of degrees"
	| myVector anAngleInRadians newX newY newEndPoint |
	
	myVector := self vector negated.
	anAngleInRadians := anAngleDegrees degreesToRadians.
	newX := (myVector x * anAngleInRadians cos) - (myVector y * anAngleInRadians sin).
	newY := (myVector x * anAngleInRadians sin) + (myVector y * anAngleInRadians cos).
	
	newEndPoint := self toVertex point + (newX @ newY).
	self fromVertex point: newEndPoint
]

{ #category : #'api - transformations' }
BlShaperLine >> clockwiseRotateAroundStartBy: anAngleDegrees [
	"rotate the line clockwise around a start vertex by the given amount of degrees"
	| myVector anAngleInRadians newX newY newEndPoint |
	
	myVector := self vector.
	anAngleInRadians := anAngleDegrees degreesToRadians.
	newX := (myVector x * anAngleInRadians cos) - (myVector y * anAngleInRadians sin).
	newY := (myVector x * anAngleInRadians sin) + (myVector y * anAngleInRadians cos).
	
	newEndPoint := self fromVertex point + (newX @ newY).
	self toVertex point: newEndPoint
]

{ #category : #'api - transformations' }
BlShaperLine >> collapse [
	"Merge the vertices in the center of the line and replace the line with just one point.
	Return the resulting point"
	<return: #BlShaperVertex>
	| myVector newVertex aFromVertex aToVertex |

	aFromVertex := self fromVertex.
	aToVertex := self toVertex.
	myVector := self vector.

	aFromVertex moveBy: myVector / 2.0.
	aToVertex moveBy: myVector / 2.0 negated.

	newVertex := BlShaperVertex new point: aFromVertex point.

	aFromVertex incomingEdge toVertex: newVertex.
	aToVertex outgoingEdge fromVertex: newVertex.

	self figure removeEdge: self.

	^ newVertex
]

{ #category : #'api - transformations' }
BlShaperLine >> counterClockwiseRotateAroundEndBy: anAngleDegrees [
	"rotate the line counter-clockwise around an end vertex by the given amount of degrees"
	
	self clockwiseRotateAroundEndBy: anAngleDegrees negated
]

{ #category : #'api - transformations' }
BlShaperLine >> counterClockwiseRotateAroundStartBy: anAngleDegrees [
	"rotate the line counter-clockwise around a start vertex by the given amount of degrees"
	
	self clockwiseRotateAroundStartBy: anAngleDegrees negated
]

{ #category : #'api - transformations' }
BlShaperLine >> explodeEndVertex: aLength [
	"Divide the end vertex (#toVertex) in such a way that:
	 - the resulting line is perpendicular to me
	 - its length is equal to a given number
	 - the center of the line is located where the end vertex was previously located"
	| myVector aPerpendicular aResultingLine |

	myVector := self vector negated.
	aPerpendicular := myVector normal.
	
	aResultingLine := self toVertex divide.
	aResultingLine resizeTo: aLength alongVectorIfZero: aPerpendicular.
	
	^ aResultingLine
]

{ #category : #'api - transformations' }
BlShaperLine >> explodeStartVertex: aLength [
	"Divide the start vertex (#fromVertex) in such a way that:
	 - the resulting line is perpendicular to me
	 - its length is equal to a given number
	 - the center of the line is located where the start vertex was previously located"
	| myVector aPerpendicular aResultingLine |

	myVector := self vector.
	aPerpendicular := myVector normal.
	
	aResultingLine := self fromVertex divide.
	aResultingLine resizeTo: aLength alongVectorIfZero: aPerpendicular.
	
	^ aResultingLine
]

{ #category : #accessing }
BlShaperLine >> figure [
	^ figure
]

{ #category : #accessing }
BlShaperLine >> figure: anObject [
	figure := anObject
]

{ #category : #accessing }
BlShaperLine >> fromVertex [
	^ fromVertex
]

{ #category : #accessing }
BlShaperLine >> fromVertex: aTBlShapeEdge [
	fromVertex ifNotNil: [ fromVertex removeOutgoingEdge ].
	fromVertex := aTBlShapeEdge.
	fromVertex outgoingEdge: self
]

{ #category : #'api - transformations' }
BlShaperLine >> injectLineAt: aFloat length: aLength [
	| aLeftSplitPoint aRightSplitPoint aRightLine aLeftLine aCenterLine |
	
	"handle a potential zero divide"
	(self fromVertex point closeTo: self toVertex point)
		ifTrue: [
			aLeftSplitPoint := (BlShaperVertex point: self toVertex point).
			aRightSplitPoint := (BlShaperVertex point: self toVertex point) ]
		ifFalse: [
			| aLineVector aSplitPoint |
			aLineVector := self vector.
			aSplitPoint := self fromVertex point + (aLineVector * aFloat).

			aLeftSplitPoint := (BlShaperVertex point: aSplitPoint - (aLength / 2.0 * aLineVector normalized)).
			aRightSplitPoint := (BlShaperVertex point: aSplitPoint + (aLength / 2.0 * aLineVector normalized)) ].

	aLeftLine := BlShaperLine new
		fromVertex: self fromVertex;
		toVertex: aLeftSplitPoint.

	aCenterLine := BlShaperLine new
		fromVertex: aLeftSplitPoint;
		toVertex: aRightSplitPoint.

	aRightLine := BlShaperLine new
		fromVertex: aRightSplitPoint;
		toVertex: self toVertex.
	
	self figure
		addEdge: aLeftLine after: self;
		addEdge: aCenterLine after: aLeftLine;
		addEdge: aRightLine after: aCenterLine;
		removeEdge: self
]

{ #category : #accessing }
BlShaperLine >> length [
	<return: #Number>
	
	^ self vector length
]

{ #category : #accessing }
BlShaperLine >> middle [
	<return: #Point>

	^ (self fromVertex point + (self vector normalized * self length / 2.0)) asPoint
]

{ #category : #'api - transformations' }
BlShaperLine >> moveAlongNormalBy: aLength [
	self moveBy: (self vector normal * aLength)
]

{ #category : #printing }
BlShaperLine >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	aStream
		nextPutAll: 'Line from: ';
		print: fromVertex.
	aStream
		nextPutAll: ' to: ';
		print: toVertex.
	aStream
		nextPutAll: ' length: ';
		print: self length
]

{ #category : #'api - transformations' }
BlShaperLine >> resizeFromEndBy: aNumber [
	"Move end vertex so that my length increases or decreases by aNumber"
	self
		resizeFromEndTo: self length + aNumber
		alongVectorIfZero: (BlVector x: -1 y: 0)
]

{ #category : #'api - transformations' }
BlShaperLine >> resizeFromEndTo: aNumber [
	"Move end vertex so that my length becomes equal to aNumber"
	self
		resizeFromEndTo: aNumber
		alongVectorIfZero: (BlVector x: -1 y: 0)
]

{ #category : #'api - transformations' }
BlShaperLine >> resizeFromEndTo: aNumber alongVectorIfZero: anIfZeroVector [
	"Move the end vertex closer to the start so that my length becomes equal to aNumber.
	If the length of the line is zero use a given vector as a basis for the translation"
	| myVector aTranslationVector myCurrentLength theLengthDelta |

	myVector := self vector.
	myCurrentLength := myVector length.
	
	"positive if we expand the line"
	theLengthDelta := (aNumber - myVector length).
	
	myCurrentLength isZero
		ifTrue: [
			| aNormalizedTranslationVector |
			
			aNormalizedTranslationVector := anIfZeroVector isZero
				ifTrue: [ BlVector x: -1 y: 0 ]
				ifFalse: [ anIfZeroVector normalized ].
				
			aTranslationVector := aNormalizedTranslationVector * theLengthDelta.
			
			self toVertex moveBy: aTranslationVector negated .
			^ self ].
	
	aTranslationVector := myVector normalized * theLengthDelta.
	
	self toVertex moveBy: aTranslationVector 
]

{ #category : #'api - transformations' }
BlShaperLine >> resizeFromStartBy: aNumber [
	"Move start vertex so that my length increases or decreases by aNumber"
	self
		resizeFromStartTo: self length + aNumber
		alongVectorIfZero: (BlVector x: -1 y: 0)
]

{ #category : #'api - transformations' }
BlShaperLine >> resizeFromStartTo: aNumber [
	"Move start vertex so that my length becomes equal to aNumber"
	self
		resizeFromStartTo: aNumber
		alongVectorIfZero: (BlVector x: -1 y: 0)
]

{ #category : #'api - transformations' }
BlShaperLine >> resizeFromStartTo: aNumber alongVectorIfZero: anIfZeroVector [
	"Move the start vertex closer to the end so that my length becomes equal to aNumber.
	If the length of the line is zero use a given vector as a basis for the translation"
	| myVector aTranslationVector myCurrentLength theLengthDelta |

	myVector := self vector.
	myCurrentLength := myVector length.
	
	"positive if we expand the line"
	theLengthDelta := aNumber - myVector length.
	
	myCurrentLength isZero
		ifTrue: [
			| aNormalizedTranslationVector |
			
			aNormalizedTranslationVector := anIfZeroVector isZero
				ifTrue: [ BlVector x: -1 y: 0 ]
				ifFalse: [ anIfZeroVector normalized ].
				
			aTranslationVector := aNormalizedTranslationVector * theLengthDelta.
			
			self fromVertex moveBy: aTranslationVector.
			^ self ].
	
	aTranslationVector := myVector normalized * theLengthDelta.
	
	self fromVertex moveBy: aTranslationVector negated
]

{ #category : #'api - transformations' }
BlShaperLine >> resizeTo: aNumber [
	"Move two connection points closer or apart so that my length becomes equal to aNumber"
	self
		resizeTo: aNumber
		alongVectorIfZero: (BlVector x: -1 y: 0)
]

{ #category : #'api - transformations' }
BlShaperLine >> resizeTo: aNumber alongVectorIfZero: anIfZeroVector [
	"Move the vertices closer or apart so that my length becomes equal to aNumber.
	If the length of the line is zero use a given vector as a basis for the translation"
	| myVector aTranslationVector myCurrentLength theLengthDelta |

	myVector := self vector.
	myCurrentLength := myVector length.
	
	"positive if we expand the line"
	theLengthDelta := (aNumber - myVector length) / 2.0.
	
	myCurrentLength isZero
		ifTrue: [
			| aNormalizedTranslationVector |
			
			aNormalizedTranslationVector := anIfZeroVector isZero
				ifTrue: [ BlVector x: -1 y: 0 ]
				ifFalse: [ anIfZeroVector normalized ].
				
			aTranslationVector := aNormalizedTranslationVector * theLengthDelta.
			
			self fromVertex moveBy: aTranslationVector .
			self toVertex moveBy: aTranslationVector negated .
			^ self ].
	
	aTranslationVector := myVector normalized * theLengthDelta.
	
	self fromVertex moveBy: aTranslationVector negated.
	self toVertex moveBy: aTranslationVector 
]

{ #category : #'api - transformations' }
BlShaperLine >> rotateAroundStartBy: anAngleDegrees [
	
]

{ #category : #'api - transformations' }
BlShaperLine >> splitAt: aFloat [
	| aSplitPoint aLeftLine aRightLine |

	aSplitPoint := BlShaperVertex new point: (self fromVertex point + (self vector * aFloat)) asPoint.

	aLeftLine := BlShaperLine new
		fromVertex: self fromVertex;
		toVertex: aSplitPoint.

	aRightLine := BlShaperLine new
		fromVertex: aSplitPoint;
		toVertex: self toVertex.
		
	self figure
		addEdge: aLeftLine after: self;
		addEdge: aRightLine after: aLeftLine;
		removeEdge: self
]

{ #category : #accessing }
BlShaperLine >> toVertex [
	^ toVertex
]

{ #category : #accessing }
BlShaperLine >> toVertex: aTBlShapeEdge [
	toVertex ifNotNil: [ toVertex removeIncomingEdge ].
	toVertex := aTBlShapeEdge.
	toVertex incomingEdge: self
]

{ #category : #accessing }
BlShaperLine >> vector [
	^ (self toVertex point - self fromVertex point) asBlocVector
]

{ #category : #accessing }
BlShaperLine >> vertices [
	^ { self fromVertex . self toVertex }
]
