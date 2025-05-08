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
		topItemOffset: 10;
		bottomItemOffset: 30;
		topItemIndex: 2.
	
	filler := BlVirtualListSpaceFiller new
		setFetcher: fetcher
		viewport: viewport
		measurementSpec: (BlExtentMeasurementSpec exact: 200@220).

	^ filler
]
