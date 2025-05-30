Class {
	#name : #BlResizerElementExamples,
	#superclass : #Object,
	#category : #'BlocPac-Resizable-Examples'
}

{ #category : #examples }
BlResizerElementExamples >> bottomCenterResize [
	<gtExample>
	<return: #BlElement>
	| container vector |
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.

	BlSpace
		simulateDragOn: (container childNamed: #resizer) bottomCenter
		by: vector.

	self
		assert: (container childNamed: #resizable) extent
		equals: self initialExtent + (0 @ vector y).
	self
		assert: (container childNamed: #resizable) position
		equals: self initialPosition.

	^ container
]

{ #category : #examples }
BlResizerElementExamples >> bottomLeftResize [
	<gtExample>
	<return: #BlElement>
	| container vector |
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.

	BlSpace simulateDragOn: (container childNamed: #resizer) bottomLeft by: vector.

	self
		assert: (container childNamed: #resizable) extent
		equals: self initialExtent + ((0 - vector x) @ vector y).
	self
		assert: (container childNamed: #resizable) position
		equals: self initialPosition + (vector x @ 0).

	^ container
]

{ #category : #'examples - advanced' }
BlResizerElementExamples >> bottomResizerBarInsideContainer [
	<gtExample>
	<return: #BlElement>
	| aContainer aResizer |
	aContainer := BlElement new.
	aContainer height: 300.
	aContainer constraintsDo: [ :c | c horizontal matchParent ].
	aContainer relocate: 0 @ 50.
	aContainer border: (BlBorder paint: Color lightGray width: 1).

	aResizer := BlElement new.
	aResizer background: (Color gray alpha: 0.5).
	aResizer geometry: (BlRoundedRectangleGeometry cornerRadius: 2).
	aResizer
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c vertical exact: 4.
			c horizontal exact: 70.
			c ignored vertical alignBottom.
			c ignored horizontal alignCenter.
			c margin: (BlInsets bottom: 4) ].
	aResizer
		addEventHandler: (BlResizerBottomListener new resizeTarget: aContainer).

	aContainer addChild: aResizer.

	^ aContainer
]

{ #category : #examples }
BlResizerElementExamples >> bottomRightResize [
	<gtExample>
	<return: #BlElement>
	| container vector |
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.

	BlSpace simulateDragOn: (container childNamed: #resizer) bottomRight by: vector.

	self
		assert: (container childNamed: #resizable) extent
		equals: self initialExtent + vector.
	self
		assert: (container childNamed: #resizable) position
		equals: self initialPosition.

	^ container
]

{ #category : #'instance creation' }
BlResizerElementExamples >> container [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 500 @ 500;
		background: (Color gray alpha: 0.4)
]

{ #category : #'instance creation' }
BlResizerElementExamples >> containerWithResizable [
	<gtExample>
	<return: #BlElement>
	| container resizable resizer |
	container := self container.

	resizable := self resizable.
	resizer := self resizer attachTo: resizable.

	container addChild: resizable as: #resizable.
	container addChild: resizer as: #resizer.

	^ container
]

{ #category : #'instance creation' }
BlResizerElementExamples >> initialExtent [
	^ 100@100
]

{ #category : #'instance creation' }
BlResizerElementExamples >> initialPosition [
	^ 100@100
]

{ #category : #examples }
BlResizerElementExamples >> middleLeftResize [
	<gtExample>
	<return: #BlElement>
	| container vector |
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.

	BlSpace simulateDragOn: (container childNamed: #resizer) middleLeft by: vector.

	self
		assert: (container childNamed: #resizable) extent
		equals: self initialExtent - (vector x @ 0).
	self
		assert: (container childNamed: #resizable) position
		equals: self initialPosition + (vector x @ 0).

	^ container
]

{ #category : #examples }
BlResizerElementExamples >> middleRightResize [
	<gtExample>
	<return: #BlElement>
	| container vector |
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.

	BlSpace simulateDragOn: (container childNamed: #resizer) middleRight by: vector.

	self
		assert: (container childNamed: #resizable) extent
		equals: self initialExtent + (vector x @ 0).
	self
		assert: (container childNamed: #resizable) position
		equals: self initialPosition.

	^ container
]

{ #category : #'instance creation' }
BlResizerElementExamples >> resizable [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: self initialExtent;
		relocate: self initialPosition;
		background: (Color red alpha: 0.5)
]

{ #category : #examples }
BlResizerElementExamples >> resizeEvents [
	<gtExample>
	<return: #OrderedCollection>
	| container vector resizeEvents resizeStartedEvent resizeEndedEvent resizeEvent |
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.

	resizeEvents := OrderedCollection new.

	(container childNamed: #resizable)
		when: BlResizerResizeStartedEvent
			do: [ :anEvent | resizeEvents add: anEvent ];
		when: BlResizerResizeEndedEvent do: [ :anEvent | resizeEvents add: anEvent ];
		when: BlResizerResizedEvent do: [ :anEvent | resizeEvents add: anEvent ].

	BlSpace simulateDragOn: (container childNamed: #resizer) topCenter by: vector.

	self assert: resizeEvents size equals: 3.

	resizeStartedEvent := resizeEvents first.
	self assert: resizeStartedEvent class equals: BlResizerResizeStartedEvent.
	self assert: resizeStartedEvent originalExtent equals: self initialExtent.

	resizeEndedEvent := resizeEvents third.
	self assert: resizeEndedEvent class equals: BlResizerResizeEndedEvent.
	self assert: resizeEndedEvent originalExtent equals: self initialExtent.
	self
		assert: resizeEndedEvent modifiedExtent
		equals: self initialExtent - (0 @ vector y).

	resizeEvent := resizeEvents second.
	self assert: resizeEvent class equals: BlResizerResizedEvent.
	self assert: resizeEvent extent equals: self initialExtent - (0 @ vector y).

	^ resizeEvents
]

{ #category : #'instance creation' }
BlResizerElementExamples >> resizer [
	<gtExample>
	<return: #BlResizerElement>
	^ BlResizerElement new
]

{ #category : #examples }
BlResizerElementExamples >> topCenterResize [
	<gtExample>
	<return: #BlElement>
	| container vector |
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.

	BlSpace simulateDragOn: (container childNamed: #resizer) topCenter by: vector.

	self
		assert: (container childNamed: #resizable) extent
		equals: self initialExtent - (0 @ vector y).
	self
		assert: (container childNamed: #resizable) position
		equals: self initialPosition + (0 @ vector y).

	^ container
]

{ #category : #examples }
BlResizerElementExamples >> topLeftResize [
	<gtExample>
	<return: #BlElement>
	| container vector |
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.

	BlSpace simulateDragOn: (container childNamed: #resizer) topLeft by: vector.

	self
		assert: (container childNamed: #resizable) extent
		equals: self initialExtent - vector.
	self
		assert: (container childNamed: #resizable) position
		equals: self initialPosition + vector.

	^ container
]

{ #category : #examples }
BlResizerElementExamples >> topRightResize [
	<gtExample>
	<return: #BlElement>
	| container vector |
	vector := BlVector x: 50 y: 50.
	container := self containerWithResizable.

	BlSpace simulateDragOn: (container childNamed: #resizer) topRight by: vector.

	self
		assert: (container childNamed: #resizable) extent
		equals: self initialExtent + (vector x @ (0 - vector y)).
	self
		assert: (container childNamed: #resizable) position
		equals: self initialPosition + (0 @ vector y).

	^ container
]
