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
BlVirtualListSpaceFillerExamples >> fillAt1AlignTopOffset0FitContent [
	<gtExample>
	| filler state |
	
	filler := self fillerForFitContentAtAnchor: (BlVirtualListFillerAnchor new
		dataSourceIndex: 1;
		elementAlignment: BlElementAlignment vertical start;
		offset: 0).

	state := filler fillSpace.

	"state
		assert: state filledElementsMeasuredBounds
		equals: {0 @ 0.0 corner: 200.0 @ 50.0.
			0 @ 50.0 corner: 200.0 @ 100.0.
			0 @ 100.0 corner: 200.0 @ 150.0.
			0 @ 150.0 corner: 200.0 @ 200.0.
			0 @ 200.0 corner: 200.0 @ 250.0 }."
	
	^ state
]

{ #category : #examples }
BlVirtualListSpaceFillerExamples >> fillAt1AlignTopOffset0FitContentWithViewport [
	<gtExample>
	| filler state |
	
	filler := self fillerForFitContentAtAnchor: (BlVirtualListFillerAnchor new
			dataSourceIndex: 1;
			elementAlignment: BlElementAlignment vertical start;
			offset: 0)
		viewport: (0@120 extent: 300@500).

	state := filler fillSpace.

	state
		assert: state filledElementsMeasuredBounds
		equals: {0 @ 0.0 corner: 500.0 @ 50.0.
				0 @ 50.0 corner: 500 @ 100.0.
				0 @ 100.0 corner: 500 @ 150.0.
				0 @ 150.0 corner: 500 @ 200.0.
				0 @ 200.0 corner: 500 @ 250.0.
				0 @ 250.0 corner: 500 @ 300.0.
				0 @ 300.0 corner: 500 @ 350.0.
				0 @ 350.0 corner: 500 @ 400.0.
				0 @ 400.0 corner: 500 @ 450.0.
				0 @ 450.0 corner: 500 @ 500.0.
				0 @ 500.0 corner: 500 @ 550.0.
				0 @ 550.0 corner: 500 @ 600.0.
				0 @ 600.0 corner: 500 @ 650.0}.
				
	state assert: state viewport
		equals: (BlVirtualListViewport new
			bottomItemIndex: 0;
			bottomItemOffset: 0;
			topItemIndex: 0;
			topItemOffset: 0).
	
	^ state
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

	self
		assert: state filledElementsMeasuredBounds
		equals: {0 @ -45.0 corner: 200.0 @ 5.0.
				0 @ 5.0 corner: 200.0 @ 55.0.
				0 @ 55.0 corner: 200.0 @ 105.0.
				0 @ 105.0 corner: 200.0 @ 155.0.
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

{ #category : #'instance creation' }
BlVirtualListSpaceFillerExamples >> fillerForFitContentAtAnchor: aFillerAnchor [
	^ self
		fillerForFitContentAtAnchor: aFillerAnchor
		viewport: nil
]

{ #category : #'instance creation' }
BlVirtualListSpaceFillerExamples >> fillerForFitContentAtAnchor: aFillerAnchor viewport: aViewportRectangleOrNil [
	| dataSource fetcher filler |

	dataSource := BlVirtualListExampleColorsDataSource new.
	fetcher := BlVirtualListElementFetcher new setDataSource: dataSource.

	filler := BlVirtualListSpaceFiller new
		setFetcher: fetcher
		anchor: aFillerAnchor
		measurementSpec: (BlExtentMeasurementSpec new
			widthSpec: (BlMeasurementSpec exact: 500);
			heightSpec: BlMeasurementSpec unspecified;
			viewport: aViewportRectangleOrNil).

	^ filler
]
