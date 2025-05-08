Class {
	#name : #BlVirtualListSpaceFillerState,
	#superclass : #Object,
	#instVars : [
		'filledElements',
		'itemCount',
		'totalHeight',
		'totalWidth',
		'currentDataSourceIndex',
		'availableHeight'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #accessing }
BlVirtualListSpaceFillerState >> availableHeight [
	^ availableHeight
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> availableHeight: anObject [
	availableHeight := anObject
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> currentDataSourceIndex [
	^ currentDataSourceIndex
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> currentDataSourceIndex: anObject [
	currentDataSourceIndex := anObject
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> filledElements [
	^ filledElements
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> initialize [
	super initialize.
	
	filledElements := LinkedList new
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> itemCount [
	^ itemCount
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> postCopy [
	filledElements := filledElements copy
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> totalHeight [
	^ totalHeight
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> totalHeight: anObject [
	totalHeight := anObject
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> totalWidth [
	^ totalWidth
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> totalWidth: anObject [
	totalWidth := anObject
]
