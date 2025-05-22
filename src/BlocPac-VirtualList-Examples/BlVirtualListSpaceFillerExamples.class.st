Class {
	#name : #BlVirtualListSpaceFillerExamples,
	#superclass : #Object,
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #examples }
BlVirtualListSpaceFillerExamples >> fillAt1AlignBottomOffset0 [
	<gtExample>
	| filler state |
	
	filler := self fillerFor: 200@220 atAnchor: (BlVirtualListFillerAnchor new
		dataSourceIndex: 1;
		elementAlignment: BlElementAlignment vertical end;
		offset: 0).

	state := filler fillSpace.

	state
		assert: state filledElementsMeasuredBounds
		equals: {0 @ 170.0 corner: 200.0 @ 220.0}.
	
	^ filler
]

{ #category : #examples }
BlVirtualListSpaceFillerExamples >> fillAt1AlignCenterOffset0 [
	<gtExample>
	| filler state |
	
	filler := self fillerFor: 200@220 atAnchor: (BlVirtualListFillerAnchor new
		dataSourceIndex: 1;
		elementAlignment: BlElementAlignment vertical center;
		offset: 0).

	state := filler fillSpace.

	state
		assert: state filledElementsMeasuredBounds
		equals: {0 @ 85.0 corner: 200.0 @ 135.0.
			0 @ 135.0 corner: 200.0 @ 185.0.
			0 @ 185.0 corner: 200.0 @ 235.0}.
	
	^ filler
]

{ #category : #examples }
BlVirtualListSpaceFillerExamples >> fillAt1AlignTopOffset0 [
	<gtExample>
	| filler state |
	
	filler := self fillerFor: 200@220 atAnchor: (BlVirtualListFillerAnchor new
		dataSourceIndex: 1;
		elementAlignment: BlElementAlignment vertical start;
		offset: 0).

	state := filler fillSpace.

	state
		assert: state filledElementsMeasuredBounds
		equals: {0 @ 0.0 corner: 200.0 @ 50.0.
			0 @ 50.0 corner: 200.0 @ 100.0.
			0 @ 100.0 corner: 200.0 @ 150.0.
			0 @ 150.0 corner: 200.0 @ 200.0.
			0 @ 200.0 corner: 200.0 @ 250.0 }.
	
	^ filler
]

{ #category : #examples }
BlVirtualListSpaceFillerExamples >> fillAt3AlignBottomOffset10 [
	<gtExample>
	| filler state |
	
	filler := self fillerFor: 200@220 atAnchor: (BlVirtualListFillerAnchor new
		dataSourceIndex: 3;
		elementAlignment: BlElementAlignment vertical end;
		offset: 10).

	state := filler fillSpace.

	state
		assert: state filledElementsMeasuredBounds
		equals: {0 @ 80.0 corner: 200.0 @ 130.0.
			0 @ 130.0 corner: 200.0 @ 180.0.
			10 @ 180.0 corner: 210.0 @ 230.0}.
	
	^ filler
]

{ #category : #examples }
BlVirtualListSpaceFillerExamples >> fillAt6AlignCenterOffset0 [
	<gtExample>
	| filler state |
	
	filler := self fillerFor: 200@220 atAnchor: (BlVirtualListFillerAnchor new
		dataSourceIndex: 6;
		elementAlignment: BlElementAlignment vertical center;
		offset: 0).

	state := filler fillSpace.

	state
		assert: state filledElementsMeasuredBounds
		equals: {0 @ -15.0 corner: 200.0 @ 35.0.
			0 @ 35.0 corner: 200.0 @ 85.0.
			0 @ 85.0 corner: 200.0 @ 135.0.
			0 @ 135.0 corner: 200.0 @ 185.0.
			0 @ 185.0 corner: 200.0 @ 235.0}.
	
	^ filler
]

{ #category : #examples }
BlVirtualListSpaceFillerExamples >> fillAt6AlignCenterOffset20 [
	<gtExample>
	| filler state |
	
	filler := self fillerFor: 200@220 atAnchor: (BlVirtualListFillerAnchor new
		dataSourceIndex: 6;
		elementAlignment: BlElementAlignment vertical center;
		offset: 20).

	state := filler fillSpace.

	state
		assert: state filledElementsMeasuredBounds
		equals: {0 @ -45.0 corner: 200.0 @ 5.0.
			0 @ 5.0 corner: 200.0 @ 55.0.
			0 @ 55.0 corner: 200.0 @ 105.0.
			20 @ 105.0 corner: 220.0 @ 155.0.
			0 @ 155.0 corner: 200.0 @ 205.0.
			0 @ 205.0 corner: 200.0 @ 255.0}.
	
	^ filler
]

{ #category : #'instance creation' }
BlVirtualListSpaceFillerExamples >> fillerFor: aListExtent atAnchor: aFillerAnchor [
	| dataSource fetcher filler |
	dataSource := BlVirtualListExampleColorsDataSource new.
	fetcher := BlVirtualListElementFetcher new setDataSource: dataSource.

	filler := BlVirtualListSpaceFiller new
		setFetcher: fetcher
		anchor: aFillerAnchor
		measurementSpec: (BlExtentMeasurementSpec exact: aListExtent).

	^ filler
]
