"
Anchor relative anchor computes its position based on other anchors

"
Class {
	#name : #BlAnchorRelativeToAnchor,
	#superclass : #BlGeometryAnchor,
	#instVars : [
		'referenceAnchors'
	],
	#category : #'BlocPac-Geometry-Anchors'
}

{ #category : #start }
BlAnchorRelativeToAnchor >> attachToAnchoredElement: anAnchoredElement [
	super attachToAnchoredElement: anAnchoredElement.
	
	referenceAnchors do: [ :eachAnchor | eachAnchor attachToAnchoredElement: anAnchoredElement ]
]

{ #category : #start }
BlAnchorRelativeToAnchor >> detachFromAnchoredElement: anAnchoredElement [
	super detachFromAnchoredElement: anAnchoredElement.
	
	referenceAnchors do: [ :eachAnchor | eachAnchor detachFromAnchoredElement: anAnchoredElement ]
]

{ #category : #accessing }
BlAnchorRelativeToAnchor >> referenceAnchors [
	<return: #SequenceableCollection of: #BlGeometryAnchor>

	^ referenceAnchors
]

{ #category : #accessing }
BlAnchorRelativeToAnchor >> referenceAnchors: anObject [
	referenceAnchors := anObject
]
