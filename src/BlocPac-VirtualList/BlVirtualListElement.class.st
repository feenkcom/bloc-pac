Class {
	#name : #BlVirtualListElement,
	#superclass : #BlElement,
	#instVars : [
		'dataSource',
		'viewport',
		'scrollbar'
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
	
	viewport := BlVirtualListViewport new.
	
	self when: BlMouseWheelEvent do: [ :anEvent |
		self scrollBy: anEvent vector
	].
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
	| fetcher anchor filler state filledHeight|
	
	dataSource
		ifNil: [ ^ self ].
	
	fetcher := BlVirtualListElementFetcher new setDataSource: dataSource.
	
	anchor := BlVirtualListFillerAnchor new
		dataSourceIndex: viewport topItemIndex;
		elementAlignment: BlElementAlignment vertical start;
		offset: viewport topItemOffset.
	
	filler := BlVirtualListSpaceFiller new
		setFetcher: fetcher
		anchor: anchor
		measurementSpec: anExtentMeasurementSpec.

	state := filler fillSpace.
	viewport := state viewport.
	
	self ignoreRequestLayoutDuring: [
		self removeChildren.
		self addChildren: (state filledElements collect: [ :each | each element ] as: Array) ].
	
	filledHeight := state lastVisibleFilledItemBottom - state firstVisibleFilledItemTop.
	
	self measuredExtent: (anExtentMeasurementSpec sizeFor: 0 @ filledHeight)
]

{ #category : #'as yet unclassified' }
BlVirtualListElement >> scrollBy: anOffsetPoint [
	viewport topItemOffset: viewport topItemOffset + anOffsetPoint y.
	self requestLayout
]

{ #category : #accessing }
BlVirtualListElement >> viewport [
	^ viewport
]
