Class {
	#name : #BlEllipseElementExamples,
	#superclass : #BlGeometryElementExamples,
	#category : #'BlocPac-Geometry-Examples'
}

{ #category : #examples }
BlEllipseElementExamples >> circle [
	<gtExample>
	<return: #BlElement>
	| anEllipse aCenterPoint |
	aCenterPoint := self attachPoint relocate: 150 @ 100.

	anEllipse := BlEllipseElement radius: 75.
	anEllipse centerAnchor: (BlElementCenterAnchor element: aCenterPoint).
	anEllipse background: (Color gray alpha: 0.3).
	anEllipse border: (BlBorder paint: Color gray width: 2).

	^ self container
		addChildren: {anEllipse.
				aCenterPoint}
]

{ #category : #examples }
BlEllipseElementExamples >> ellipse [
	<gtExample>
	<return: #BlElement>
	| anEllipse aCenterPoint |
	aCenterPoint := self attachPoint relocate: 150 @ 100.

	anEllipse := BlEllipseElement new
			majorRadius: 100;
			minorRadius: 50.
	anEllipse centerAnchor: (BlElementCenterAnchor element: aCenterPoint).
	anEllipse background: (Color gray alpha: 0.3).
	anEllipse border: (BlBorder paint: Color gray width: 2).

	^ self container
		addChildren: {anEllipse.
				aCenterPoint}
]
