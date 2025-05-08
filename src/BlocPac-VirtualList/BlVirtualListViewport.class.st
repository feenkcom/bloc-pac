Class {
	#name : #BlVirtualListViewport,
	#superclass : #Object,
	#instVars : [
		'topItemIndex',
		'topItemOffset',
		'bottomItemIndex',
		'bottomItemOffset'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #accessing }
BlVirtualListViewport >> bottomItemIndex [
	^ bottomItemIndex
]

{ #category : #accessing }
BlVirtualListViewport >> bottomItemIndex: anObject [
	bottomItemIndex := anObject
]

{ #category : #accessing }
BlVirtualListViewport >> bottomItemOffset [
	^ bottomItemOffset
]

{ #category : #accessing }
BlVirtualListViewport >> bottomItemOffset: anObject [
	bottomItemOffset := anObject
]

{ #category : #initialization }
BlVirtualListViewport >> initialize [
	super initialize.
	
	topItemIndex := 1.
	topItemOffset := 0.0.
	bottomItemIndex := 1.
	bottomItemOffset := 0.0
]

{ #category : #accessing }
BlVirtualListViewport >> itemToFillFrom [
	topItemOffset <= 0.0
		ifTrue: [ ^ BlVirtualListVisibleItem new
				beTop;
				dataSourceIndex: topItemIndex;
				offset: topItemOffset ].

	bottomItemOffset <= 0.0
		ifTrue: [ ^ BlVirtualListVisibleItem new
				beBottom;
				dataSourceIndex: bottomItemIndex;
				offset: bottomItemOffset ].

	^ topItemOffset < bottomItemOffset
		ifTrue: [ BlVirtualListVisibleItem new
				beTop;
				dataSourceIndex: topItemIndex;
				offset: topItemOffset ]
		ifFalse: [ BlVirtualListVisibleItem new
				beBottom;
				dataSourceIndex: bottomItemIndex;
				offset: bottomItemOffset ]
]

{ #category : #accessing }
BlVirtualListViewport >> topItemIndex [
	^ topItemIndex
]

{ #category : #accessing }
BlVirtualListViewport >> topItemIndex: anObject [
	topItemIndex := anObject
]

{ #category : #accessing }
BlVirtualListViewport >> topItemOffset [
	^ topItemOffset
]

{ #category : #accessing }
BlVirtualListViewport >> topItemOffset: anObject [
	topItemOffset := anObject
]
