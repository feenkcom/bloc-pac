Class {
	#name : #BlVirtualListElementFetcher,
	#superclass : #Object,
	#instVars : [
		'dataSource',
		'attachedElements'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #accessing }
BlVirtualListElementFetcher >> attachedElements: aDictionary [
	attachedElements := aDictionary
]

{ #category : #accessing }
BlVirtualListElementFetcher >> dataSource [
	^ dataSource
]

{ #category : #accessing }
BlVirtualListElementFetcher >> fetchElementAt: aDataSourceIndex [
	attachedElements
		at: aDataSourceIndex
		ifPresent: [ :anElement |
			attachedElements removeKey: aDataSourceIndex.
			^ anElement ].

	^ self fetchNewElementFor: (dataSource itemAt: aDataSourceIndex) index: aDataSourceIndex
]

{ #category : #'as yet unclassified' }
BlVirtualListElementFetcher >> fetchNewElementFor: anObject index: aDataSourceIndex [
	| newElement |
	
	newElement := dataSource createElement.
	dataSource
		bindElement: newElement
		item: anObject
		index: aDataSourceIndex.

	^ newElement
]

{ #category : #initialization }
BlVirtualListElementFetcher >> initialize [
	super initialize.
	
	attachedElements := Dictionary new
]

{ #category : #accessing }
BlVirtualListElementFetcher >> setDataSource: anObject [
	dataSource := anObject
]
