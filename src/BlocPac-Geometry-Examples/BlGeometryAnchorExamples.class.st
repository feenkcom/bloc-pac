Class {
	#name : #BlGeometryAnchorExamples,
	#superclass : #Object,
	#category : #'BlocPac-Geometry-Examples'
}

{ #category : #'anchor - accessing' }
BlGeometryAnchorExamples >> bottomCenterAnchor [
	<gtExample>
	<return: #BlElementBottomCenterAnchor>
	| anAnchor |
	anAnchor := BlElementBottomCenterAnchor new.

	self
		assert: (anAnchor
				positionWithinBounds: (BlBounds origin: 40.0 @ 20.0 extent: 200.0 @ 100.0))
		equals: 140 @ 120.

	^ anAnchor
]

{ #category : #'anchor - accessing' }
BlGeometryAnchorExamples >> bottomLeftAnchor [
	<gtExample>
	<return: #BlElementBottomLeftAnchor>
	| anAnchor |
	anAnchor := BlElementBottomLeftAnchor new.

	self
		assert: (anAnchor
				positionWithinBounds: (BlBounds origin: 40.0 @ 20.0 extent: 200.0 @ 100.0))
		equals: 40 @ 120.

	^ anAnchor
]

{ #category : #'anchor - accessing' }
BlGeometryAnchorExamples >> bottomRightAnchor [
	<gtExample>
	<return: #BlElementBottomRightAnchor>
	| anAnchor |
	anAnchor := BlElementBottomRightAnchor new.

	self
		assert: (anAnchor
				positionWithinBounds: (BlBounds origin: 40.0 @ 20.0 extent: 200.0 @ 100.0))
		equals: 240 @ 120.

	^ anAnchor
]

{ #category : #'anchor - accessing' }
BlGeometryAnchorExamples >> centerAnchor [
	<gtExample>
	<return: #BlElementCenterAnchor>
	| anAnchor |
	anAnchor := BlElementCenterAnchor new.

	self
		assert: (anAnchor
				positionWithinBounds: (BlBounds origin: 40.0 @ 20.0 extent: 200.0 @ 100.0))
		equals: 140 @ 70.

	^ anAnchor
]

{ #category : #'anchor - accessing' }
BlGeometryAnchorExamples >> centerLeftAnchor [
	<gtExample>
	<return: #BlElementCenterLeftAnchor>
	| anAnchor |
	anAnchor := BlElementCenterLeftAnchor new.

	self
		assert: (anAnchor
				positionWithinBounds: (BlBounds origin: 40.0 @ 20.0 extent: 200.0 @ 100.0))
		equals: 40 @ 70.

	^ anAnchor
]

{ #category : #'anchor - accessing' }
BlGeometryAnchorExamples >> centerRightAnchor [
	<gtExample>
	<return: #BlElementCenterRightAnchor>
	| anAnchor |
	anAnchor := BlElementCenterRightAnchor new.

	self
		assert: (anAnchor
				positionWithinBounds: (BlBounds origin: 40.0 @ 20.0 extent: 200.0 @ 100.0))
		equals: 240 @ 70.

	^ anAnchor
]

{ #category : #'anchor - accessing' }
BlGeometryAnchorExamples >> topCenterAnchor [
	<gtExample>
	<return: #BlElementTopCenterAnchor>
	| anAnchor |
	anAnchor := BlElementTopCenterAnchor new.

	self
		assert: (anAnchor
				positionWithinBounds: (BlBounds origin: 40.0 @ 20.0 extent: 200.0 @ 100.0))
		equals: 140 @ 20.

	^ anAnchor
]

{ #category : #'anchor - accessing' }
BlGeometryAnchorExamples >> topLeftAnchor [
	<gtExample>
	<return: #BlElementTopLeftAnchor>
	| anAnchor |
	anAnchor := BlElementTopLeftAnchor new.

	self
		assert: (anAnchor
				positionWithinBounds: (BlBounds origin: 40.0 @ 20.0 extent: 200.0 @ 100.0))
		equals: 40 @ 20.

	^ anAnchor
]

{ #category : #'anchor - accessing' }
BlGeometryAnchorExamples >> topRightAnchor [
	<gtExample>
	<return: #BlElementTopRightAnchor>
	| anAnchor |
	anAnchor := BlElementTopRightAnchor new.

	self
		assert: (anAnchor
				positionWithinBounds: (BlBounds origin: 40.0 @ 20.0 extent: 200.0 @ 100.0))
		equals: 240 @ 20.

	^ anAnchor
]
