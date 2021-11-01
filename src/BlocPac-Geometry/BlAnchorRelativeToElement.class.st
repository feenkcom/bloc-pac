"
Relative anchor takes an arbitrary element as a reference an compute its position based on properties of that element.

"
Class {
	#name : #BlAnchorRelativeToElement,
	#superclass : #BlGeometryAnchor,
	#instVars : [
		'referenceElement'
	],
	#category : #'BlocPac-Geometry-Anchors'
}

{ #category : #'instance creation' }
BlAnchorRelativeToElement class >> element: anElement [
	<return: #BlAnchorRelativeToElement>

	^ self new
		referenceElement: anElement;
		yourself
]

{ #category : #accessing }
BlAnchorRelativeToElement class >> label [
	<return: #String>
	
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
BlAnchorRelativeToElement class >> referenceElement: anElement relatedTo: anotherElement [
	"Some types of achors should take other element into account"
	<return: #BlAnchorRelativeToElement>

	"By default most we only care about a single reference element"
	^ self element: anElement
]

{ #category : #start }
BlAnchorRelativeToElement >> attachToAnchoredElement: anAnchoredElement [
	super attachToAnchoredElement: anAnchoredElement.
	
	anAnchoredElement registerDependentElement: self referenceElement
]

{ #category : #start }
BlAnchorRelativeToElement >> detachFromAnchoredElement: anAnchoredElement [
	super detachFromAnchoredElement: anAnchoredElement.
	
	anAnchoredElement unregisterDependentElement: self referenceElement
]

{ #category : #'testing - self anchors' }
BlAnchorRelativeToElement >> isSelfTo: anAnotherAnchor [
	<return: #Boolean>
	
	^ anAnotherAnchor isSelfToRelative: self
]

{ #category : #'testing - self anchors' }
BlAnchorRelativeToElement >> isSelfToAbsolute: anAnotherAnchor [
	<return: #Boolean>
	
	^ false
]

{ #category : #'testing - self anchors' }
BlAnchorRelativeToElement >> isSelfToRelative: anAnotherAnchor [
	<return: #Boolean>

	^ self referenceElement = anAnotherAnchor referenceElement
]

{ #category : #geometry }
BlAnchorRelativeToElement >> positionForAnchoredElement: aGeometryElement within: aCommonParent [
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlAnchorRelativeToElement >> referenceElement [
	<return: #BlElement>

	^ referenceElement
]

{ #category : #accessing }
BlAnchorRelativeToElement >> referenceElement: anElement [
	self
		assert: [ anElement isNotNil ]
		description: [ 'Reference element must not be nil' ].

	self
		assert: [ referenceElement isNil ]
		description: [ 'Reference element can not be changed once set' ].

	referenceElement := anElement
]

{ #category : #geometry }
BlAnchorRelativeToElement >> selfPositionsForAnchoredElement: anAnchoredElement and: anAnotherAnchor within: aCommonParent [
	<return: #Collection of: #Point>
	| aFromPoint aToPoint theBoundsInCommonParent aFromRay aToRay aDirectionVector aLength |

	aFromPoint := self
		              positionForAnchoredElement: anAnchoredElement
		              within: aCommonParent.

	aToPoint := anAnotherAnchor
		            positionForAnchoredElement: anAnchoredElement
		            within: aCommonParent.

	theBoundsInCommonParent := (self referenceElement bounds inParent: aCommonParent) bounds.

	aFromRay := theBoundsInCommonParent outsideNormalCloseTo: aFromPoint.
	aToRay := theBoundsInCommonParent outsideNormalCloseTo: aToPoint.

	(aFromRay vector isParallel: aToRay vector) ifTrue: [ 
		aFromRay vector rotateBy: 45 degreesToRadians.
		aToRay vector rotateBy: 45 negated degreesToRadians ].

	aDirectionVector := (aToPoint - aFromPoint) asBlocVector * 2.
	aLength := aDirectionVector length max: 150.

	^ { 
		  (aFromRay point + (aFromRay vector * aLength)).
		  (aToRay point + (aToRay vector * aLength)) }
]
