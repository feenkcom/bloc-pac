Class {
	#name : #BlVirtualListSpaceFillerExamples,
	#superclass : #Object,
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerExamples >> colorsFiller [
	<gtExample>
	| dataSource fetcher viewport filler |
	
	dataSource := BlVirtualListExampleColorsDataSource new.
	fetcher := BlVirtualListElementFetcher new setDataSource: dataSource.
	viewport := BlVirtualListViewport new
		topItemOffset: 100;
		topItemIndex: 3;
		bottomItemIndex: 3;
		bottomItemOffset: 60.
	
	filler := BlVirtualListSpaceFiller new
		setFetcher: fetcher
		viewport: viewport
		measurementSpec: (BlExtentMeasurementSpec exact: 200@220).

	^ filler
]
