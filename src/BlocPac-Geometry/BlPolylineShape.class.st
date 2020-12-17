Class {
	#name : #BlPolylineShape,
	#superclass : #BlCurveShape,
	#category : #'BlocPac-Geometry-Shaper'
}

{ #category : #converting }
BlPolylineShape >> appendPathTo: aPathBuilder [
	self shapes do: [ :eachShape | eachShape appendPathTo: aPathBuilder ]
]

{ #category : #accessing }
BlPolylineShape >> segmentAt: aNumber [
	^ self shapes at: aNumber
]
