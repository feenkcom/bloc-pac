Class {
	#name : #BlInfiniteScrollFlinger,
	#superclass : #BlScrollFlinger,
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'BlocPac-Infinite-Scroller'
}

{ #category : #'instance creation' }
BlInfiniteScrollFlinger class >> on: anInfiniteElement [
	^ self new
		initializeWith: anInfiniteElement;
		yourself
]

{ #category : #hooks }
BlInfiniteScrollFlinger >> onInitialized [
	self scrollable eatRequestLayout.
	self scrollable onEnterLayoutOrScroll
]

{ #category : #hooks }
BlInfiniteScrollFlinger >> onLayoutScrolled [
	self scrollable repositionShadowingElements.
	self scrollable onExitLayoutOrScroll.
	self scrollable resumeRequestLayout: false
]

{ #category : #hooks }
BlInfiniteScrollFlinger >> onPrepareToRun [
	self scrollable consumePendingDataSourceCommands
]
