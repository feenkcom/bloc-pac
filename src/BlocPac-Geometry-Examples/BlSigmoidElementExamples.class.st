Class {
	#name : #BlSigmoidElementExamples,
	#superclass : #BlGeometryElementExamples,
	#category : #'BlocPac-Geometry-Examples'
}

{ #category : #'examples - instance creation' }
BlSigmoidElementExamples >> newSigmoid [
	<gtExample>
	<return: #BlSigmoidElement>
	^ BlSigmoidElement new
		zIndex: 10;
		border: (BlBorder paint: Color red width: 4);
		yourself
]

{ #category : #'examples - orientation' }
BlSigmoidElementExamples >> sigmoidAutomatic [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.
	aSigmoid beAutomatic.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #'examples - bending point' }
BlSigmoidElementExamples >> sigmoidBendingFirstQuarterPoint [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.
	aSigmoid bendingPoint: 0.25.
	aSigmoid sharpness: 1.0.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #'examples - bending point' }
BlSigmoidElementExamples >> sigmoidBendingFourthQuarterPoint [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.
	aSigmoid bendingPoint: 0.75.
	aSigmoid sharpness: 1.0.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #'examples - bending point' }
BlSigmoidElementExamples >> sigmoidBendingMiddlePoint [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.
	aSigmoid bendingPoint: 0.5.
	aSigmoid sharpness: 1.0.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #'examples - sigmoid' }
BlSigmoidElementExamples >> sigmoidDefault [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #'examples - orientation' }
BlSigmoidElementExamples >> sigmoidHorizontal [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.
	aSigmoid beHorizontal.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #'examples - orientation' }
BlSigmoidElementExamples >> sigmoidHorizontalLine [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.
	aSigmoid beHorizontal.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 100.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #'examples - sharpness' }
BlSigmoidElementExamples >> sigmoidSharp [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.
	aSigmoid sharpness: 1.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #'examples - sharpness' }
BlSigmoidElementExamples >> sigmoidSmooth [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.	"it degrades to a line"
	aSigmoid sharpness: 0.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #'examples - sharpness' }
BlSigmoidElementExamples >> sigmoidSoft [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.
	aSigmoid sharpness: 0.5.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]

{ #category : #'examples - orientation' }
BlSigmoidElementExamples >> sigmoidVertical [
	<gtExample>
	<return: #BlElement>
	| aSigmoid attachFrom attachTo |
	aSigmoid := self newSigmoid.
	aSigmoid beVertical.

	attachFrom := self attachPoint.
	attachFrom relocate: 100 @ 100.

	attachTo := self attachPoint.
	attachTo relocate: 450 @ 200.

	aSigmoid fromAnchor: (BlElementCenterAnchor element: attachFrom).
	aSigmoid toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {aSigmoid.
				attachFrom.
				attachTo}
]
