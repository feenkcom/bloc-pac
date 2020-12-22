Class {
	#name : #BlThreeSegmentPolylineShape,
	#superclass : #BlPolylineShape,
	#category : #'BlocPac-Geometry-Shaper'
}

{ #category : #accessing }
BlThreeSegmentPolylineShape >> middle [
	^ self segmentAt: 2
]
