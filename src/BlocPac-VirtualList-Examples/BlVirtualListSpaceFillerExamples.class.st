Class {
	#name : #BlVirtualListSpaceFillerExamples,
	#superclass : #Object,
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerExamples >> colorsFiller [
	<gtExample>
	| dataSource fetcher anchor filler |
	
	dataSource := BlVirtualListExampleColorsDataSource new.
	fetcher := BlVirtualListElementFetcher new setDataSource: dataSource.
	anchor := BlVirtualListFillerAnchor new
		dataSourceIndex: 1;
		elementAlignment: BlElementAlignment vertical center;
		offset: 0.
	
	filler := BlVirtualListSpaceFiller new
		setFetcher: fetcher
		anchor: anchor
		measurementSpec: (BlExtentMeasurementSpec exact: 200@220).

	^ filler
]
