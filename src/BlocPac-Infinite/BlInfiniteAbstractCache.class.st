Class {
	#name : #BlInfiniteAbstractCache,
	#superclass : #Object,
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #cache }
BlInfiniteAbstractCache >> elementFor: aRecycler at: aPosition type: anItemType [
	^ self subclassResponsibility
]
