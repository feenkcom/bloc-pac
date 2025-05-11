Class {
	#name : #BlVirtualListElementFetcher,
	#superclass : #Object,
	#instVars : [
		'dataSource'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #accessing }
BlVirtualListElementFetcher >> dataSource [
	^ dataSource
]

{ #category : #'as yet unclassified' }
BlVirtualListElementFetcher >> fetchElementAt: aDataSourceIndex [
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

{ #category : #accessing }
BlVirtualListElementFetcher >> setDataSource: anObject [
	dataSource := anObject
]
