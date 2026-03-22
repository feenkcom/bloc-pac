Class {
	#name : #BlVirtualListExplicitDataSource,
	#superclass : #BlVirtualListDataSource,
	#instVars : [
		'elementStencil',
		'dataBinder',
		'items'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #'as yet unclassified' }
BlVirtualListExplicitDataSource >> bindElement: anElement item: anObject index: anIndex [
	dataBinder cull: anElement cull: anObject cull: anIndex
]

{ #category : #'as yet unclassified' }
BlVirtualListExplicitDataSource >> createElement [
	^ elementStencil asElement
]

{ #category : #accessing }
BlVirtualListExplicitDataSource >> dataBinder [
	^ dataBinder
]

{ #category : #accessing }
BlVirtualListExplicitDataSource >> dataBinder: anObject [
	dataBinder := anObject
]

{ #category : #accessing }
BlVirtualListExplicitDataSource >> elementStencil [
	^ elementStencil
]

{ #category : #accessing }
BlVirtualListExplicitDataSource >> elementStencil: anObject [
	elementStencil := anObject asStencil
]

{ #category : #'as yet unclassified' }
BlVirtualListExplicitDataSource >> itemAt: anIndex [
	^ self items at: anIndex
]

{ #category : #'as yet unclassified' }
BlVirtualListExplicitDataSource >> itemCount [
	^ self items size
]

{ #category : #accessing }
BlVirtualListExplicitDataSource >> items [
	^ items
]

{ #category : #accessing }
BlVirtualListExplicitDataSource >> items: anObject [
	items := anObject
]
