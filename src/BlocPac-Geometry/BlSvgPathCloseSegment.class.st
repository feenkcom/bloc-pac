Class {
	#name : #BlSvgPathCloseSegment,
	#superclass : #BlSvgPathSegment,
	#category : #'BlocPac-Geometry-SVG'
}

{ #category : #comparing }
BlSvgPathCloseSegment >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
		
	^ anotherObject isAbsolute = self isAbsolute
]

{ #category : #executing }
BlSvgPathCloseSegment >> executeOn: aBuilder [
	aBuilder close
]

{ #category : #comparing }
BlSvgPathCloseSegment >> hash [
	^ self class hash bitXor: self isAbsolute hash
]

{ #category : #printing }
BlSvgPathCloseSegment >> printOn: aStream [
	aStream
		nextPutAll: 'Close'
]
