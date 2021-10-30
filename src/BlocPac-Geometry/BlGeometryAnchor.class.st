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
BlGeometryAnchor >> computePositionWithin: anAnchoredElement [
	"Return anchor position within a given geometry element in its parent bounds"
	<return: #Point>

	anAnchoredElement commonAnchorParentDo: [ :aCommonParent |
		| aPositionInCommonParent |

		aPositionInCommonParent := self
			positionForAnchoredElement: anAnchoredElement
			within: aCommonParent.

		^ anAnchoredElement globalPointToParentChildren: aPositionInCommonParent fromParent: aCommonParent ].

	^ 0@0
]

{ #category : #'anchor - lifecycle' }
BlGeometryAnchor >> detachFromAnchoredElement: aGeometryElement [
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
BlGeometryAnchor >> positionForAnchoredElement: aGeometryElement within: aCommonParent [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

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
BlGeometryAnchor >> selfPositionsForAnchoredElement: anAnchoredElement and: anAnotherAnchor within: aCommonParent [
	<return: #Collection of: #Point>

	^ self subclassResponsibility
]

{ #category : #geometry }
BlGeometryAnchor >> selfPositionsWithin: anAnchoredElement and: anAnotherAnchor [
	<return: #Collection of: #Point>
	
	anAnchoredElement commonAnchorParentDo: [ :aCommonParent |
		| theSelfPositions |

		theSelfPositions := self
			selfPositionsForAnchoredElement: anAnchoredElement
			and: anAnotherAnchor
			within: aCommonParent.
			
		^ theSelfPositions collect: [ :eachPoint | anAnchoredElement globalPointToParentChildren: eachPoint fromParent: aCommonParent ] ].

	^ 0@0
]
