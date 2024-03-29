"
I am a static anchor that does not move and is independent from geometry element or other anchors.

"
Class {
	#name : #BlAbsolutePositionAnchor,
	#superclass : #BlGeometryAnchor,
	#instVars : [
		'position'
	],
	#category : #'BlocPac-Geometry-Anchors'
}

{ #category : #accessing }
BlAbsolutePositionAnchor class >> position: aPoint [
	"Create and return a new static line anchor with a given position as a point"
	
	^ self new
		position: aPoint;
		yourself
]

{ #category : #testing }
BlAbsolutePositionAnchor >> isSelfTo: anAnotherAnchor [
	<return: #Boolean>
	
	^ anAnotherAnchor isSelfToAbsolute: self
]

{ #category : #testing }
BlAbsolutePositionAnchor >> isSelfToAbsolute: anAnotherAnchor [
	<return: #Boolean>
	
	^ self position closeTo: anAnotherAnchor position
]

{ #category : #testing }
BlAbsolutePositionAnchor >> isSelfToRelative: anAnotherAnchor [
	<return: #Boolean>
	
	^ false
]

{ #category : #accessing }
BlAbsolutePositionAnchor >> position [
	^ position
]

{ #category : #accessing }
BlAbsolutePositionAnchor >> position: aPoint [
	position := aPoint
]

{ #category : #geometry }
BlAbsolutePositionAnchor >> positionForAnchoredElement: aGeometryElement within: aCommonParent [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	
	^ aGeometryElement hasParent
		ifTrue: [ aCommonParent localPointToMine: (aGeometryElement parent childrenPointToLocal: self position) fromChild: aGeometryElement parent ]
		ifFalse: [ self position ]
]

{ #category : #printing }
BlAbsolutePositionAnchor >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' position: ';
		print: position
]
