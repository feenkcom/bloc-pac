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
	
	^ state
]

{ #category : #examples }
BlVirtualListSpaceFillerExamples >> fillAt1AlignTopOffset0FitContentWithViewport [
	<gtExample>
	| filler state |
	filler := self
			fillerForFitContentAtAnchor: (BlVirtualListFillerAnchor new
					dataSourceIndex: 1;
					elementAlignment: BlElementAlignment vertical start;
					offset: 0)
			viewport: (0 @ 120 extent: 300 @ 500).

	state := filler fillSpace.

	state
		assert: state filledElementsMeasuredBounds
		equals: {0 @ 100.0 corner: 500 @ 150.0.
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

	state
		assert: state viewport
		equals: (BlVirtualListViewport new
				topItemIndex: 3;
				topItemOffset: 100.0;
				bottomItemIndex: 13;
				bottomItemOffset: 650.0).

	^ filler
]

{ #category : #examples }
BlVirtualListSpaceFillerExamples >> fillAt1AlignTopOffset0FitContentWithViewportOutside [
	<gtExample>
	| dataSource filler state |

	dataSource := BlVirtualListExplicitDataSource new
		elementStencil: [ BlElement new size: 100 @ 20 ];
		dataBinder: [ :eachLabel :eachNumber | ];
		items: (1 to: 10).

	filler := self
			fillerForHeightSpec: (BlMeasurementSpec exact: 300)
			atAnchor: (BlVirtualListFillerAnchor new
					dataSourceIndex: 1;
					elementAlignment: BlElementAlignment vertical start;
					offset: -220)
			dataSource: dataSource
			viewport: (BlExtentMeasurementViewport fromTopEdge: (0 @ 220 extent: 500 @ 300)).

	state := filler fillSpace.
	
	self
		assert: state measuredHeight asNumber
		equals: 200.

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
BlVirtualListSpaceFillerExamples >> fillAt1AlignTopOffsetNegative60 [
	<gtExample>
	| filler state |
	filler := self
			fillerFor: 200 @ 220
			atAnchor: (BlVirtualListFillerAnchor new
					dataSourceIndex: 1;
					elementAlignment: BlElementAlignment vertical start;
					offset: -60).

	state := filler fillSpace.

	self
		assert: state filledElementsMeasuredBounds
		equals: {0 @ -10.0 corner: 200.0 @ 40.0.
				0 @ 40.0 corner: 200.0 @ 90.0.
				0 @ 90.0 corner: 200.0 @ 140.0.
				0 @ 140.0 corner: 200.0 @ 190.0.
				0 @ 190.0 corner: 200.0 @ 240.0}.

	self
		assert: state viewport
		equals: (BlVirtualListViewport new
				topItemIndex: 2;
				topItemOffset: -10.0;
				bottomItemIndex: 6;
				bottomItemOffset: 20.0).

	^ filler
]

{ #category : #examples }
BlVirtualListSpaceFillerExamples >> fillAt3AlignBottomOffset10 [
	<gtExample>
	| filler state |
	filler := self
			fillerFor: 200 @ 220
			atAnchor: (BlVirtualListFillerAnchor new
					dataSourceIndex: 3;
					elementAlignment: BlElementAlignment vertical end;
					offset: 10).

	state := filler fillSpace.

	state
		assert: state filledElementsMeasuredBounds
		equals: {0 @ 80.0 corner: 200.0 @ 130.0.
				0 @ 130.0 corner: 200.0 @ 180.0.
				0 @ 180.0 corner: 200.0 @ 230.0}.

	state
		assert: state viewport
		equals: (BlVirtualListViewport new
				topItemIndex: 1;
				topItemOffset: 80.0;
				bottomItemIndex: 3;
				bottomItemOffset: 10.0).

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

{ #category : #'examples - nested' }
BlVirtualListSpaceFillerExamples >> fillNestedAt1AlignTopOffsetNextBarelyVisible [
	<gtExample>
	| dataSource filler state |
	dataSource := BlVirtualListExplicitDataSource new
			elementStencil: [ | nestedDataSource nestedList |
				nestedDataSource := BlVirtualListExplicitDataSource new
						elementStencil: [ BlElement new size: 100 @ 20 ];
						dataBinder: [ :eachLabel :eachNumber |  ];
						items: (1 to: 10).
				nestedList := BlVirtualListElement new dataSource: nestedDataSource.

				nestedList
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal matchParent ].
				nestedList ];
			dataBinder: [ :eachLabel :eachNumber |  ];
			items: (1 to: 2).

	filler := self
			fillerForHeightSpec: (BlMeasurementSpec exact: 100)
			atAnchor: (BlVirtualListFillerAnchor new
					dataSourceIndex: 1;
					elementAlignment: BlElementAlignment vertical start;
					offset: -45)
			dataSource: dataSource
			viewport: (BlExtentMeasurementViewport fromTopEdge: (0 @ 0 extent: 500 @ 100)).

	state := filler fillSpace.
	
	filler attachedElements: state getAttachedItemElementsAndTheirIndices.
	
	state := filler fillSpace.
	"self assert: state measuredHeight asNumber equals: 400.

	self
		assert: state filledElementsMeasuredBounds
		equals: {0 @ -180 corner: 500.0 @ 20.0.
				0 @ 20.0 corner: 500 @ 220.0}.

	self
		assert: state viewport
		equals: (BlVirtualListViewport new
				topItemIndex: 1;
				topItemOffset: -180;
				bottomItemIndex: 2;
				bottomItemOffset: 120.0)."

	^ state
]

{ #category : #'examples - nested' }
BlVirtualListSpaceFillerExamples >> fillNestedAt1AlignTopOffsetNotVisible [
	<gtExample>
	| dataSource filler state |
	dataSource := BlVirtualListExplicitDataSource new
			elementStencil: [ | nestedDataSource nestedList |
				nestedDataSource := BlVirtualListExplicitDataSource new
						elementStencil: [ BlElement new size: 100 @ 20 ];
						dataBinder: [ :eachLabel :eachNumber | ];
						items: (1 to: 10).
				nestedList := BlVirtualListElement new dataSource: nestedDataSource.

				nestedList
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal matchParent ].
				nestedList ];
			dataBinder: [ :eachLabel :eachNumber |  ];
			items: (1 to: 2).

	filler := self
			fillerForHeightSpec: (BlMeasurementSpec exact: 100)
			atAnchor: (BlVirtualListFillerAnchor new
					dataSourceIndex: 1;
					elementAlignment: BlElementAlignment vertical start;
					offset: -220)
			dataSource: dataSource
			viewport: (BlExtentMeasurementViewport fromTopEdge: (0 @ 0 extent: 500 @ 100)).

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

{ #category : #'examples - nested' }
BlVirtualListSpaceFillerExamples >> fillNestedAt1AlignTopOffsetPartiallyVisible [
	<gtExample>
	| dataSource filler state |
	dataSource := BlVirtualListExplicitDataSource new
			elementStencil: [ | nestedDataSource nestedList |
				nestedDataSource := BlVirtualListExplicitDataSource new
						elementStencil: [ BlElement new size: 100 @ 20 ];
						dataBinder: [ :eachLabel :eachNumber |  ];
						items: (1 to: 10).
				nestedList := BlVirtualListElement new dataSource: nestedDataSource.

				nestedList
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal matchParent ].
				nestedList ];
			dataBinder: [ :eachLabel :eachNumber |  ];
			items: (1 to: 2).

	filler := self
			fillerForHeightSpec: (BlMeasurementSpec exact: 100)
			atAnchor: (BlVirtualListFillerAnchor new
					dataSourceIndex: 1;
					elementAlignment: BlElementAlignment vertical start;
					offset: -180)
			dataSource: dataSource
			viewport: (BlExtentMeasurementViewport fromTopEdge: (0 @ 0 extent: 500 @ 100)).

	state := filler fillSpace.

	self assert: state measuredHeight asNumber equals: 400.

	self
		assert: state filledElementsMeasuredBounds
		equals: {0 @ -180 corner: 500.0 @ 20.0.
				0 @ 20.0 corner: 500 @ 220.0}.

	self
		assert: state viewport
		equals: (BlVirtualListViewport new
				topItemIndex: 1;
				topItemOffset: -180;
				bottomItemIndex: 2;
				bottomItemOffset: 120.0).

	^ state
]

{ #category : #'examples - nested' }
BlVirtualListSpaceFillerExamples >> fillNestedAt1AlignTopOffsetVisible [
	<gtExample>
	| dataSource filler state |
	dataSource := BlVirtualListExplicitDataSource new
			elementStencil: [ | nestedDataSource nestedList |
				nestedDataSource := BlVirtualListExplicitDataSource new
						elementStencil: [ BlElement new size: 100 @ 20 ];
						dataBinder: [ :eachLabel :eachNumber |  ];
						items: (1 to: 10).
				nestedList := BlVirtualListElement new dataSource: nestedDataSource.

				nestedList
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal matchParent ].
				nestedList ];
			dataBinder: [ :eachLabel :eachNumber |  ];
			items: (1 to: 2).

	filler := self
			fillerForHeightSpec: (BlMeasurementSpec exact: 100)
			atAnchor: (BlVirtualListFillerAnchor new
					dataSourceIndex: 1;
					elementAlignment: BlElementAlignment vertical start;
					offset: 0)
			dataSource: dataSource
			viewport: (BlExtentMeasurementViewport fromTopEdge: (0 @ 0 extent: 500 @ 100)).

	state := filler fillSpace.
	
	self
		assert: state measuredHeight asNumber
		equals: 100.

	self
		assert: state filledElementsMeasuredBounds
		equals: {0 @ 0 corner: 500.0 @ 100.0}.

	self
		assert: state viewport
		equals: (BlVirtualListViewport new
				topItemIndex: 1;
				topItemOffset: 0;
				bottomItemIndex: 1;
				bottomItemOffset: 0.0).

	^ state
]

{ #category : #'examples - nested' }
BlVirtualListSpaceFillerExamples >> fillUnspecifiedHeightWithViewportPass1 [
	<gtExample>
	| dataSource firstFiller firstState firstViewport |
	dataSource := BlVirtualListExplicitDataSource new
			elementStencil: [ BlElement new size: 100 @ 20 ];
			dataBinder: [ :eachLabel :eachNumber |  ];
			items: (1 to: 10).

	firstFiller := BlVirtualListSpaceFiller new
			setFetcher: (BlVirtualListElementFetcher new setDataSource: dataSource)
			anchor: (BlVirtualListFillerAnchor new
					dataSourceIndex: 1;
					elementAlignment: BlElementAlignment vertical start;
					offset: 0.0)
			measurementSpec: (BlExtentMeasurementSpec new
					widthSpec: (BlMeasurementSpec exact: 500);
					heightSpec: BlMeasurementSpec unspecified;
					viewport: (BlExtentMeasurementViewport fromTopEdge: (0 @ 45 corner: 500 @ 145))).

	firstState := firstFiller fillSpace.
	firstViewport := firstState viewport.

	self
		assert: firstState filledElementsMeasuredBounds
		equals: {0 @ 40.0 corner: 100.0 @ 60.0.
				0 @ 60.0 corner: 100.0 @ 80.0.
				0 @ 80.0 corner: 100.0 @ 100.0.
				0 @ 100.0 corner: 100.0 @ 120.0.
				0 @ 120.0 corner: 100.0 @ 140.0.
				0 @ 140.0 corner: 100.0 @ 160.0}.
	self
		assert: firstViewport
		equals: (BlVirtualListViewport new
				topItemIndex: 3;
				topItemOffset: 40.0;
				bottomItemIndex: 8;
				bottomItemOffset: 160.0).
	self assert: firstState measuredHeight asNumber equals: 160.

	^ firstState
]

{ #category : #'examples - nested' }
BlVirtualListSpaceFillerExamples >> fillUnspecifiedHeightWithViewportPass2 [
	<gtExample>
	| dataSource firstState firstViewport secondFiller secondState secondViewport |
	dataSource := BlVirtualListExplicitDataSource new
			elementStencil: [ BlElement new size: 100 @ 20 ];
			dataBinder: [ :eachLabel :eachNumber |  ];
			items: (1 to: 10).

	firstState := self fillUnspecifiedHeightWithViewportPass1.
	firstViewport := firstState viewport.

	secondFiller := BlVirtualListSpaceFiller new
			setFetcher: (BlVirtualListElementFetcher new setDataSource: dataSource)
			anchor: (BlVirtualListFillerAnchor new
					elementAlignment: BlElementAlignment vertical start;
					dataSourceIndex: firstViewport topItemIndex;
					offset: firstViewport topItemOffset)
			measurementSpec: (BlExtentMeasurementSpec new
					widthSpec: (BlMeasurementSpec exact: 500);
					heightSpec: BlMeasurementSpec unspecified;
					viewport: (BlExtentMeasurementViewport fromTopEdge: (0 @ 45 corner: 500 @ 145))).

	secondState := secondFiller fillSpace.
	secondViewport := secondState viewport.
	self assert: secondState measuredHeight asNumber equals: 160.

	^ secondState
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
BlVirtualListSpaceFillerExamples >> fillerForFitContentAtAnchor: aFillerAnchor dataSource: aDataSource viewport: aViewportRectangleOrNil [
	| fetcher filler |

	fetcher := BlVirtualListElementFetcher new setDataSource: aDataSource.

	filler := BlVirtualListSpaceFiller new
		setFetcher: fetcher
		anchor: aFillerAnchor
		measurementSpec: (BlExtentMeasurementSpec new
			widthSpec: (BlMeasurementSpec exact: 500);
			heightSpec: BlMeasurementSpec unspecified;
			viewport: aViewportRectangleOrNil).

	^ filler
]

{ #category : #'instance creation' }
BlVirtualListSpaceFillerExamples >> fillerForFitContentAtAnchor: aFillerAnchor viewport: aViewportRectangleOrNil [
	^ self
		fillerForFitContentAtAnchor: aFillerAnchor
		dataSource: BlVirtualListExampleColorsDataSource new
		viewport: aViewportRectangleOrNil
]

{ #category : #'instance creation' }
BlVirtualListSpaceFillerExamples >> fillerForHeightSpec: aHeightMeasurementSpec atAnchor: aFillerAnchor dataSource: aDataSource viewport: aViewportRectangleOrNil [
	| fetcher filler |

	fetcher := BlVirtualListElementFetcher new setDataSource: aDataSource.

	filler := BlVirtualListSpaceFiller new
		setFetcher: fetcher
		anchor: aFillerAnchor
		measurementSpec: (BlExtentMeasurementSpec new
			widthSpec: (BlMeasurementSpec exact: 500);
			heightSpec: aHeightMeasurementSpec;
			viewport: aViewportRectangleOrNil).

	^ filler
]
