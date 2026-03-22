Class {
	#name : #BlSvgPathQuadraticBezierSegment,
	#superclass : #BlSvgPathSegment,
	#instVars : [
		'viaPoint',
		'curveTo'
	],
	#category : #'BlocPac-Geometry-SVG'
}

{ #category : #comparing }
BlSvgPathQuadraticBezierSegment >> = anotherObject [

	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].

	^ anotherObject isAbsolute = self isAbsolute
		and: [ anotherObject curveTo = self curveTo
			and: [ anotherObject viaPoint = self viaPoint ] ]
]

{ #category : #accessing }
BlSvgPathQuadraticBezierSegment >> curveTo [
	^ curveTo
]

{ #category : #accessing }
BlSvgPathQuadraticBezierSegment >> curveTo: anObject [
	curveTo := anObject
]

{ #category : #executing }
BlSvgPathQuadraticBezierSegment >> executeOn: aBuilder [
	aBuilder curveVia: self viaPoint to: self curveTo 
]

{ #category : #comparing }
BlSvgPathQuadraticBezierSegment >> hash [
	^ (self isAbsolute hash bitXor: self curveTo hash) bitXor: self viaPoint hash
]

{ #category : #testing }
BlSvgPathQuadraticBezierSegment >> isQuadraticBezier [
	^ true
]

{ #category : #accessing }
BlSvgPathQuadraticBezierSegment >> lastControlPointForFollowingCurrentPoint: aCurrentPoint [
	^ self isAbsolute
		ifTrue: [ self viaPoint ]
		ifFalse: [ (aCurrentPoint - self curveTo) + self viaPoint ]
]

{ #category : #accessing }
BlSvgPathQuadraticBezierSegment >> viaPoint [
	^ viaPoint
]

{ #category : #accessing }
BlSvgPathQuadraticBezierSegment >> viaPoint: anObject [
	viaPoint := anObject
]
