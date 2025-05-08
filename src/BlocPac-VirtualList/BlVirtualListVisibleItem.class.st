Class {
	#name : #BlVirtualListVisibleItem,
	#superclass : #Object,
	#instVars : [
		'dataSourceIndex',
		'offset',
		'anchorEdge'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #accessing }
BlVirtualListVisibleItem >> anchorEdge [
	^ anchorEdge
]

{ #category : #accessing }
BlVirtualListVisibleItem >> anchorEdge: anObject [
	anchorEdge := anObject
]

{ #category : #location }
BlVirtualListVisibleItem >> beBottom [
	anchorEdge := #bottom
]

{ #category : #location }
BlVirtualListVisibleItem >> beTop [
	anchorEdge := #top
]

{ #category : #accessing }
BlVirtualListVisibleItem >> dataSourceIndex [
	^ dataSourceIndex
]

{ #category : #accessing }
BlVirtualListVisibleItem >> dataSourceIndex: anObject [
	dataSourceIndex := anObject
]

{ #category : #accessing }
BlVirtualListVisibleItem >> ifTop: aTopBlock ifBottom: aBottomBlock [
	anchorEdge = #top
		ifTrue: [ ^ aTopBlock cull: self ].
	anchorEdge = #bottom
		ifTrue: [ ^ aBottomBlock cull: self ].

	self error: 'Unknown anchor edge: ', anchorEdge
]

{ #category : #accessing }
BlVirtualListVisibleItem >> offset [
	^ offset
]

{ #category : #accessing }
BlVirtualListVisibleItem >> offset: anObject [
	offset := anObject
]
