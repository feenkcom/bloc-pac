"
{{gtClass:BlVirtualListViewport}} represents the visual portion or window of a virtualized list that is currently visible to the user. It manages which elements from a possibly very large data source are actually rendered and displayed at any given time, based on the user's scrolling or navigation. This enables efficient memory and rendering management by only keeping visible items and some surrounding buffer in memory, improving performance for large lists.
"
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

{ #category : #comparing }
BlVirtualListViewport >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ topItemOffset = anObject topItemOffset
		and: [ bottomItemIndex = anObject bottomItemIndex
				and: [ bottomItemOffset = anObject bottomItemOffset
						and: [ topItemIndex = anObject topItemIndex ] ] ]
]

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

{ #category : #'as yet unclassified' }
BlVirtualListViewport >> gtDisplayOn: stream [
	stream
		nextPutAll: 'Top index: ';
		print: topItemIndex;
		nextPutAll: ' offset: ';
		print: topItemOffset;
		nextPutAll: ' bottom index: ';
		print: bottomItemIndex;
		nextPutAll: ' offset: ';
		print: bottomItemOffset
]

{ #category : #comparing }
BlVirtualListViewport >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ topItemOffset hash
		bitXor: (bottomItemIndex hash bitXor: (bottomItemOffset hash bitXor: topItemIndex hash))
]

{ #category : #initialization }
BlVirtualListViewport >> initialize [
	super initialize.
	
	topItemIndex := 1.
	topItemOffset := 0.0.
	bottomItemIndex := 1.
	bottomItemOffset := 0.0
]

{ #category : #'as yet unclassified' }
BlVirtualListViewport >> storeOn: aStream [
	aStream nextPut: $(.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' new '.
	aStream nextPutAll: ' topItemIndex: '.
	aStream nextPutAll: self topItemIndex printString.
	aStream nextPutAll: '; '.
	aStream nextPutAll: ' topItemOffset: '.
	aStream nextPutAll: self topItemOffset printString.
	aStream nextPutAll: '; '.
	aStream nextPutAll: ' bottomItemIndex: '.
	aStream nextPutAll: self bottomItemIndex printString.
	aStream nextPutAll: '; '.
	aStream nextPutAll: ' bottomItemOffset: '.
	aStream nextPutAll: self bottomItemOffset printString.
	aStream nextPut: $)
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
