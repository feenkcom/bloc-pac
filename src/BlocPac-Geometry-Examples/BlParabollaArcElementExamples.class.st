"
I contain examples and a few usecases of `=BlArcElement`=

"
Class {
	#name : #BlParabollaArcElementExamples,
	#superclass : #BlGeometryElementExamples,
	#category : #'BlocPac-Geometry-Examples'
}

{ #category : #'examples - connections' }
BlParabollaArcElementExamples >> absoluteCurvature [
	<gtExample>
	<return: #BlElement>
	| redArc attachFrom attachTo perpendicularAttach fromLine toLine connectLine |
	attachFrom := self attachPoint relocate: 100 @ 100.
	attachTo := self attachPoint relocate: 300 @ 400.

	redArc := self redArc.	"order does not matter"
	redArc curvature: 50.
	redArc fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redArc toAnchor: (BlElementCenterAnchor element: attachTo).	"------ fancy look ------"	"visual represenation of perpendicular anchor (does not influence the curve)"
	perpendicularAttach := BlEllipseElement radius: 15.
	perpendicularAttach background: (Color red alpha: 0.4).
	perpendicularAttach centerAnchor: redArc curvatureAnchor.	"visual connection between anchors (does not influence the curve)"
	fromLine := self greyLine.
	fromLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	fromLine toAnchor: (BlElementCenterAnchor element: perpendicularAttach).	"visual connection between anchors (does not influence the curve)"
	toLine := self greyLine.
	toLine fromAnchor: (BlElementCenterAnchor element: perpendicularAttach).
	toLine toAnchor: (BlElementCenterAnchor element: attachTo).	"visual connection between anchors (does not influence the curve)"
	connectLine := self greyLine.
	connectLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	connectLine toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {redArc.
				attachFrom.
				perpendicularAttach.
				attachTo.
				fromLine.
				toLine.
				connectLine}
]

{ #category : #'instance creation' }
BlParabollaArcElementExamples >> arc [
	<gtExample>
	<return: #BlParabollaArcElement>
	^ BlParabollaArcElement new
		zIndex: 10;
		yourself
]

{ #category : #'examples - visual properties' }
BlParabollaArcElementExamples >> blueArc [
	<gtExample>
	<return: #BlParabollaArcElement>
	^ self arc border: (BlBorder paint: Color blue width: 4)
]

{ #category : #'examples - visual properties' }
BlParabollaArcElementExamples >> blueArcWithToHead [
	<gtExample>
	<return: #BlParabollaArcElement>
	^ self blueArc
		toHead: (BlArrowheadSimpleArrow new
				arrowNoseAngle: 60;
				arrowLengthFraction: 5;
				border: (BlBorder paint: Color blue width: 2))
]

{ #category : #'examples - self edges' }
BlParabollaArcElementExamples >> bottomCenterToTopCenter [
	<gtExample>
	<return: #BlElement>
	| aCurve anElement |
	anElement := self referenceElement.

	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementBottomCenterAnchor element: anElement).
	aCurve toAnchor: (BlElementTopCenterAnchor element: anElement).

	^ self container
		addChildren: {anElement.
				aCurve}
]

{ #category : #'examples - self edges' }
BlParabollaArcElementExamples >> bottomToTopBidirectional [
	<gtExample>
	<return: #BlElement>
	| aCurveDown aCurveUp anElement |
	anElement := self referenceElement.

	aCurveDown := self blueArcWithToHead.
	aCurveDown fromAnchor: (BlElementTopCenterAnchor element: anElement).
	aCurveDown toAnchor: (BlElementBottomCenterAnchor element: anElement).

	aCurveUp := self redArcWithToHead.
	aCurveUp fromAnchor: (BlElementBottomCenterAnchor element: anElement).
	aCurveUp toAnchor: (BlElementTopCenterAnchor element: anElement).

	^ self container
		addChildren: {anElement.
				aCurveDown.
				aCurveUp}
]

{ #category : #'examples - visual properties' }
BlParabollaArcElementExamples >> greyLine [
	<gtExample>
	<return: #BlLineElement>
	^ self line
		border: (BlBorder builder
				paint: (Color gray alpha: 0.5);
				width: 1;
				build)
]

{ #category : #'examples - self edges' }
BlParabollaArcElementExamples >> leftToRightBidirectional [
	<gtExample>
	<return: #BlElement>
	| aCurveLeft aCurveRight anElement |
	anElement := self referenceElement.

	aCurveLeft := self redArcWithToHead.
	aCurveLeft fromAnchor: (BlElementCenterRightAnchor element: anElement).
	aCurveLeft toAnchor: (BlElementCenterLeftAnchor element: anElement).

	aCurveRight := self blueArcWithToHead.
	aCurveRight fromAnchor: (BlElementCenterLeftAnchor element: anElement).
	aCurveRight toAnchor: (BlElementCenterRightAnchor element: anElement).

	^ self container
		addChildren: {anElement.
				aCurveLeft.
				aCurveRight}
]

{ #category : #'instance creation' }
BlParabollaArcElementExamples >> line [
	<gtExample>
	<return: #BlLineElement>
	^ BlLineElement new
		zIndex: 10;
		yourself
]

{ #category : #'examples - visual properties' }
BlParabollaArcElementExamples >> redArc [
	<gtExample>
	<return: #BlParabollaArcElement>
	^ self arc border: (BlBorder paint: Color red width: 4)
]

{ #category : #'examples - visual properties' }
BlParabollaArcElementExamples >> redArcWithToHead [
	<gtExample>
	<return: #BlParabollaArcElement>
	^ self redArc
		toHead: (BlArrowheadSimpleArrow new
				arrowNoseAngle: 60;
				arrowLengthFraction: 5;
				border: (BlBorder paint: Color red width: 2))
]

{ #category : #'instance creation' }
BlParabollaArcElementExamples >> referenceElement [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 150 @ 150;
		relocate: 200 @ 200;
		background: (Color gray alpha: 0.2)
]

{ #category : #'examples - connections' }
BlParabollaArcElementExamples >> relativeCurvature [
	<gtExample>
	<return: #BlElement>
	| redArc attachFrom attachTo perpendicularAttach fromLine toLine connectLine |
	attachFrom := self attachPoint relocate: 100 @ 100.
	attachTo := self attachPoint relocate: 300 @ 400.

	redArc := self redArc.	"order does not matter"
	redArc curvatureFraction: 0.5.
	redArc fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redArc toAnchor: (BlElementCenterAnchor element: attachTo).	"------ fancy look ------"	"visual represenation of perpendicular anchor (does not influence the curve)"
	perpendicularAttach := BlEllipseElement radius: 15.
	perpendicularAttach background: (Color red alpha: 0.4).
	perpendicularAttach centerAnchor: redArc curvatureAnchor.	"visual connection between anchors (does not influence the curve)"
	fromLine := self greyLine.
	fromLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	fromLine toAnchor: (BlElementCenterAnchor element: perpendicularAttach).	"visual connection between anchors (does not influence the curve)"
	toLine := self greyLine.
	toLine fromAnchor: (BlElementCenterAnchor element: perpendicularAttach).
	toLine toAnchor: (BlElementCenterAnchor element: attachTo).	"visual connection between anchors (does not influence the curve)"
	connectLine := self greyLine.
	connectLine fromAnchor: (BlElementCenterAnchor element: attachFrom).
	connectLine toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {redArc.
				attachFrom.
				perpendicularAttach.
				attachTo.
				fromLine.
				toLine.
				connectLine}
]

{ #category : #'examples - connections' }
BlParabollaArcElementExamples >> relativeCurvatureWithoutDecorations [
	<gtExample>
	<return: #BlElement>
	| redArc attachFrom attachTo |
	attachFrom := (self attachPoint opacity: 0.5) relocate: 420 @ 320.
	attachTo := (self attachPoint opacity: 0.5) relocate: 120 @ 20.

	redArc := self redArc.	"order does not matter"
	redArc curvatureFraction: 0.5.
	redArc fromAnchor: (BlElementCenterAnchor element: attachFrom).
	redArc toAnchor: (BlElementCenterAnchor element: attachTo).

	^ self container
		addChildren: {redArc.
				attachFrom.
				attachTo}
]

{ #category : #'examples - self edges' }
BlParabollaArcElementExamples >> rightCenterToTopCenter [
	<gtExample>
	<return: #BlElement>
	| aCurve anElement |
	anElement := self referenceElement.

	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementCenterRightAnchor element: anElement).
	aCurve toAnchor: (BlElementTopCenterAnchor element: anElement).

	^ self container
		addChildren: {anElement.
				aCurve}
]

{ #category : #'examples - self edges' }
BlParabollaArcElementExamples >> topCenterToBottomCenter [
	<gtExample>
	<return: #BlElement>
	| aCurve anElement |
	anElement := self referenceElement.

	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementTopCenterAnchor element: anElement).
	aCurve toAnchor: (BlElementBottomCenterAnchor element: anElement).

	^ self container
		addChildren: {anElement.
				aCurve}
]

{ #category : #'examples - self edges' }
BlParabollaArcElementExamples >> topCenterToRightCenter [
	<gtExample>
	<return: #BlElement>
	| aCurve anElement |
	anElement := self referenceElement.

	aCurve := self redArcWithToHead.

	aCurve fromAnchor: (BlElementTopCenterAnchor element: anElement).
	aCurve toAnchor: (BlElementCenterRightAnchor element: anElement).

	^ self container
		addChildren: {anElement.
				aCurve}
]
