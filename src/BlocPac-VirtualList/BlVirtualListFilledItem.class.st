Class {
	#name : #BlVirtualListFilledItem,
	#superclass : #Object,
	#instVars : [
		'dataSourceIndex',
		'element',
		'bounds'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #accessing }
BlVirtualListFilledItem >> bounds [
	^ bounds
]

{ #category : #accessing }
BlVirtualListFilledItem >> bounds: anObject [
	bounds := anObject
]

{ #category : #accessing }
BlVirtualListFilledItem >> dataSourceIndex [
	^ dataSourceIndex
]

{ #category : #accessing }
BlVirtualListFilledItem >> dataSourceIndex: anObject [
	dataSourceIndex := anObject
]

{ #category : #accessing }
BlVirtualListFilledItem >> element [
	^ element
]

{ #category : #accessing }
BlVirtualListFilledItem >> element: anObject [
	element := anObject
]
