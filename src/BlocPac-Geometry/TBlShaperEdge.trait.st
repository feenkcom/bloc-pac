Trait {
	#name : #TBlShaperEdge,
	#category : 'BlocPac-Geometry-Shaper'
}

{ #category : #'api - shape' }
TBlShaperEdge >> appendPathTo: aPathBuilder [
	self explicitRequirement
]

{ #category : #accessing }
TBlShaperEdge >> vertices [
	^ self explicitRequirement
]
