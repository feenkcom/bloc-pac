Class {
	#name : #BlVirtualListElement,
	#superclass : #BlElement,
	#instVars : [
		'dataSource',
		'viewport',
		'scrollbar',
		'previousState',
		'previousFiller'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #'as yet unclassified' }
BlVirtualListElement >> createSpaceFillerAnchor: anExtentMeasurementSpec [
	viewport knowsTopItemIndex
		ifFalse: [
			^ BlVirtualListFillerAnchor new
				dataSourceIndex: 1;
				elementAlignment: BlElementAlignment vertical start;
				offset: viewport topItemOffset ].

	anExtentMeasurementSpec viewport ifNotNil: [ :aViewport |
		aViewport
			ifTop: [ ]
			ifRight: []
			ifBottom: [
				^ BlVirtualListFillerAnchor new
					dataSourceIndex: viewport bottomItemIndex;
					elementAlignment: BlElementAlignment vertical end;
					offset: viewport bottomItemOffset ]
			ifLeft:  [] ].

	^ BlVirtualListFillerAnchor new
		dataSourceIndex: viewport topItemIndex;
		elementAlignment: BlElementAlignment vertical start;
		offset: viewport topItemOffset
]

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
BlVirtualListElement >> getAttachedItemElementsAndTheirIndices [
	| attachedElements |
	attachedElements := Dictionary new.
	
	viewport knowsTopItemIndex
		ifFalse: [ ^ attachedElements ].

	self children
		withIndexDo: [ :eachElement :eachIndex | attachedElements at: viewport topItemIndex + eachIndex - 1 put: eachElement ].
	^ attachedElements
]

{ #category : #initialization }
BlVirtualListElement >> initialize [
	super initialize.
	
	viewport := BlVirtualListViewport new.
	
	self
		when: BlMouseWheelEvent
		do: [ :anEvent |
			self constraints vertical resizer isFitContent
				ifFalse: [
					self scrollBy: anEvent vector.
					anEvent consumed: true
				] ].
]

{ #category : #layout }
BlVirtualListElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	self children accountedByLayout do: [ :child |
		| childLayoutBounds |
		childLayoutBounds := child measuredBounds asRectangle.
		child applyLayoutIn: childLayoutBounds context: aBlElementBoundsUpdateContext ].
]

{ #category : #layout }
BlVirtualListElement >> onMeasure: anExtentMeasurementSpec [
	| fetcher anchor filler state filledHeight |
	"(state lastVisibleFilledItemBottom
			- state firstVisibleFilledItemTop) abs"
	dataSource ifNil: [ ^ self ].

	fetcher := BlVirtualListElementFetcher new
			attachedElements: self getAttachedItemElementsAndTheirIndices;
			setDataSource: dataSource.

	anchor := self createSpaceFillerAnchor: anExtentMeasurementSpec.

	filler := BlVirtualListSpaceFiller new
			setFetcher: fetcher
			anchor: anchor
			measurementSpec: anExtentMeasurementSpec.
	
	previousFiller := filler copy.
	
	state := filler fillSpace.
	previousState := state.
	viewport := state viewport.
	self
		ignoreRequestLayoutDuring: [ self removeChildren.
			self
				addChildren: (state filledElements collect: [ :each | each element ] as: Array) ].
	filledHeight := state measuredHeight asNumber.
	self measuredExtent: (anExtentMeasurementSpec sizeFor: 0 @ filledHeight)
]

{ #category : #scrolling }
BlVirtualListElement >> scrollBy: anOffsetPoint [
	viewport topItemOffset: viewport topItemOffset + anOffsetPoint y.
	viewport bottomItemOffset: viewport bottomItemOffset - anOffsetPoint y.
	self requestLayout
]

{ #category : #accessing }
BlVirtualListElement >> viewport [
	^ viewport
]
