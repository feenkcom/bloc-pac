Class {
	#name : #BlVirtualListElement,
	#superclass : #BlElement,
	#instVars : [
		'dataSource',
		'viewport'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #accessing }
BlVirtualListElement >> dataSource [
	^ dataSource
]

{ #category : #accessing }
BlVirtualListElement >> dataSource: anObject [
	dataSource := anObject.
	self requestLayout
]

{ #category : #'as yet unclassified' }
BlVirtualListElement >> initialize [
	super initialize.
	
	viewport := BlVirtualListViewport new
]

{ #category : #'as yet unclassified' }
BlVirtualListElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	self children accountedByLayout do: [ :child |
		| childLayoutBounds |
		childLayoutBounds := child measuredBounds asRectangle.
		child applyLayoutIn: childLayoutBounds context: aBlElementBoundsUpdateContext ].
]

{ #category : #'as yet unclassified' }
BlVirtualListElement >> onMeasure: anExtentMeasurementSpec [
	| fetcher anchor filler state |
	
	dataSource ifNil: [ ^ self ].
	
	fetcher := BlVirtualListElementFetcher new setDataSource: dataSource.
	
	anchor := BlVirtualListFillerAnchor new
		dataSourceIndex: viewport topItemIndex;
		elementAlignment: BlElementAlignment vertical start.
	
	filler := BlVirtualListSpaceFiller new
		setFetcher: fetcher
		anchor: anchor
		measurementSpec: anExtentMeasurementSpec.

	state := filler fillSpace.
	
	self ignoreRequestLayoutDuring: [
		self removeChildren.
		self addChildren: state filledElements
	].
	
	self measuredExtent: (anExtentMeasurementSpec sizeFor: 0.0@0.0).
	
]

{ #category : #accessing }
BlVirtualListElement >> viewport [
	^ viewport
]
