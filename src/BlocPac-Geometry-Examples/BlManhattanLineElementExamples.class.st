Class {
	#name : #BlManhattanLineElementExamples,
	#superclass : #BlGeometryElementExamples,
	#category : #'BlocPac-Geometry-Examples'
}

{ #category : #'examples - orientation' }
BlManhattanLineElementExamples >> addAttachmentsTo: mLine from: fromPoint to: toPoint [
	| attachFrom attachTo |
	attachFrom := self attachPoint.
	attachFrom relocate: fromPoint.
	attachTo := self attachPoint.
	attachTo relocate: toPoint.

	mLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	mLine toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {mLine.
				attachFrom.
				attachTo}
]

{ #category : #'examples - orientation' }
BlManhattanLineElementExamples >> manhattanAutomatic [
	<gtExample>
	| mLine |
	mLine := self newManhattanLine.
	mLine beAutomatic.
	^ self
		addAttachmentsTo: mLine
		from: 100 @ 100
		to: 450 @ 200
]

{ #category : #'examples - sigmoid' }
BlManhattanLineElementExamples >> manhattanDefault [
	<gtExample>	
	| mLine |
	
	mLine := self newManhattanLine.
	^ self
		addAttachmentsTo: mLine
		from: 100 @ 100
		to: 450 @ 200
]

{ #category : #'examples - orientation' }
BlManhattanLineElementExamples >> manhattanFixedFrom [
	<gtExample>
	| mLine |
	mLine := self newManhattanLine.
	mLine beFixedFrom.
	mLine fixedDistance: 50.
	^ self
		addAttachmentsTo: mLine
		from: 100 @ 100
		to: 450 @ 200
]

{ #category : #'examples - orientation' }
BlManhattanLineElementExamples >> manhattanFixedTo [
	<gtExample>
	| mLine |
	mLine := self newManhattanLine.
	mLine beFixedTo.
	mLine fixedDistance: 50.
	^ self
		addAttachmentsTo: mLine
		from: 100 @ 100
		to: 450 @ 200
]

{ #category : #'examples - orientation' }
BlManhattanLineElementExamples >> manhattanHorizontal [
	<gtExample>	
	| mLine |
	
	mLine := self newManhattanLine.
	mLine beHorizontal.
	^ self
		addAttachmentsTo: mLine
		from: 100 @ 100
		to: 450 @ 200
]

{ #category : #'examples - orientation' }
BlManhattanLineElementExamples >> manhattanHorizontalLine [
	<gtExample>
	| mLine |
	mLine := self newManhattanLine.
	mLine beHorizontal.
	^ self
		addAttachmentsTo: mLine
		from: 100 @ 100
		to: 450 @ 100
]

{ #category : #'examples - orientation' }
BlManhattanLineElementExamples >> manhattanProportional [
	<gtExample>
	| mLine |
	mLine := self newManhattanLine.
	mLine beProportional.
	mLine proportion: 0.30.
	^ self
		addAttachmentsTo: mLine
		from: 100 @ 100
		to: 450 @ 200
]

{ #category : #'examples - sigmoid' }
BlManhattanLineElementExamples >> manhattanRoundedCorners [
	<gtExample>	
	| mLine |
	
	mLine := self newManhattanLine.
	mLine cornerRadius: 20.
	^ self
		addAttachmentsTo: mLine
		from: 100 @ 100
		to: 450 @ 200
]

{ #category : #'examples - orientation' }
BlManhattanLineElementExamples >> manhattanVertical [
	<gtExample>
	| mLine |
	mLine := self newManhattanLine.
	mLine beVertical.
	^ self
		addAttachmentsTo: mLine
		from: 100 @ 100
		to: 450 @ 200
]

{ #category : #'examples - instance creation' }
BlManhattanLineElementExamples >> newManhattanLine [
	<gtExample>
	
	^ BlManhattanLineElement new
		zIndex: 10;
		border: (BlBorder paint: Color red width: 4);
		yourself
]
