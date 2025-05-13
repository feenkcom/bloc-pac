"
#Filler anchor

Describes an item from which the {{gtClass:BlVirtualListSpaceFiller}} should start filling an available space.
Once an initial item is placed, the filler decides in which direction to continue filling: top or bottom.
"
Class {
	#name : #BlVirtualListFillerAnchor,
	#superclass : #Object,
	#instVars : [
		'dataSourceIndex',
		'elementAlignment'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #accessing }
BlVirtualListFillerAnchor >> dataSourceIndex [
	^ dataSourceIndex
]

{ #category : #accessing }
BlVirtualListFillerAnchor >> dataSourceIndex: anObject [
	dataSourceIndex := anObject
]

{ #category : #accessing }
BlVirtualListFillerAnchor >> elementAlignment [
	<return: #BlElementAlignment>

	^ elementAlignment
]

{ #category : #accessing }
BlVirtualListFillerAnchor >> elementAlignment: anElementAlignment [
	elementAlignment := anElementAlignment
]
