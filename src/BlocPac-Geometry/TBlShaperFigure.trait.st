Trait {
	#name : #TBlShaperFigure,
	#category : #'BlocPac-Geometry-Shaper'
}

{ #category : #'api - shape' }
TBlShaperFigure >> addEdge: aTBlShapeEdge after: anOtherShapeEdge [
	self explicitRequirement
]

{ #category : #'api - shape' }
TBlShaperFigure >> appendPathTo: aPathBuilder [
	self edges do: [ :eachEdge | eachEdge appendPathTo: aPathBuilder ]
]

{ #category : #'api - shape' }
TBlShaperFigure >> boundingBox [
	<return: #Rectangle>
	| allVertices theBounds |
	
	allVertices := self vertices.
	
	theBounds := BlBounds origin: allVertices first point corner: allVertices first point.
	allVertices allButFirstDo: [ :eachVertex | theBounds merge: (eachVertex point corner: eachVertex point) ].
	
	^ theBounds asRectangle
]

{ #category : #'api - shape' }
TBlShaperFigure >> edgeAt: anIndex [
	^ self edges at: anIndex
]

{ #category : #'api - shape' }
TBlShaperFigure >> edges [
	^ self explicitRequirement
]

{ #category : #'gt-extension' }
TBlShaperFigure >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live';
		priority: 5;
		stencil: [
			BlElement new
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				geometry: (BlPolygonGeometry vertices: (self vertices collect: #point));
				border: (BlBorder paint: Color gray width: 2) ]
]

{ #category : #'api - shape' }
TBlShaperFigure >> value: anObject [
	^ self
]

{ #category : #'api - shape' }
TBlShaperFigure >> vertices [
	| theVertices |
	
	theVertices := OrderedDictionary new.
	self edges do: [ :eachEdge | eachEdge vertices do: [ :eachVertex | theVertices at: eachVertex put: eachVertex ] ].

	^ theVertices keys
]
