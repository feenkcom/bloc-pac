Trait {
	#name : #TBlShaperMovable,
	#category : #'BlocPac-Geometry-Shaper'
}

{ #category : #'api - movable' }
TBlShaperMovable >> moveBy: aPointOrVector [
	self vertices do: [ :eachVertex | eachVertex moveBy: aPointOrVector ]
]
