"
I represent an anchor of a geometry element, which is driven by anchor positions.

See my subclasses for a different anchor strategies.

"
Class {
	#name : #BlGeometryAnchor,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'BlocPac-Geometry-Anchors'
}

{ #category : #'anchor - lifecycle' }
BlGeometryAnchor >> attachToAnchoredElement: aGeometryElement [
]

{ #category : #geometry }
BlGeometryAnchor >> computePositionWithin: aGeometryElement [
	"Return anchor position within a given geometry element in its parent bounds"
	<return: #Point>

	^ aGeometryElement globalPointToParentChildren: (self globalPositionWithin: aGeometryElement)
]

{ #category : #'anchor - lifecycle' }
BlGeometryAnchor >> detachFromAnchoredElement: aGeometryElement [
]

{ #category : #geometry }
BlGeometryAnchor >> globalPositionWithin: aGeometryElement [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

	^ self subclassResponsibility
]

{ #category : #geometry }
BlGeometryAnchor >> globalSelfPositionsWithin: aGeometryElement and: anAnotherAnchor [
	<return: #Collection of: #Point>

	^ self subclassResponsibility
]

{ #category : #'testing - self anchors' }
BlGeometryAnchor >> isSelfTo: anAnotherAnchor [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'testing - self anchors' }
BlGeometryAnchor >> isSelfToAbsolute: anAnotherAnchor [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #'testing - self anchors' }
BlGeometryAnchor >> isSelfToRelative: anAnotherAnchor [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlGeometryAnchor >> positionWithin: aGeometryElement [
	"Compute and return a position of this anchor in parent coordinates of the *anchor* element
	taking into account a given geometry element"
	<return: #Point>
	
	^ self computePositionWithin: aGeometryElement
]

{ #category : #geometry }
BlGeometryAnchor >> selfPositionsWithin: aGeometryElement and: anAnotherAnchor [
	<return: #Collection of: #Point>
	
	^ (self globalSelfPositionsWithin: aGeometryElement and: anAnotherAnchor)
			collect: [ :aPoint | aGeometryElement globalPointToParentChildren: aPoint ]
]
