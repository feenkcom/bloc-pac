Class {
	#name : #BlVirtualListDataSource,
	#superclass : #Object,
	#category : #'BlocPac-VirtualList'
}

{ #category : #'as yet unclassified' }
BlVirtualListDataSource >> bindElement: anElement item: anObject index: anIndex [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BlVirtualListDataSource >> createElement [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BlVirtualListDataSource >> itemAt: anIndex [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BlVirtualListDataSource >> itemCount [
	^ self subclassResponsibility
]
