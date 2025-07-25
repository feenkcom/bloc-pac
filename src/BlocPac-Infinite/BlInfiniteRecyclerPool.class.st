"
# Recycler pool

I let users to share Elements between multiple {{gtClass:BlInfiniteElement}}.

If you want to recycle elements across `InfiniteElement`, create an instance of `RecyclerPool` and use {{gtMethod:BlInfiniteElement>>#recyclerPool:}}.

`InfiniteElement` automatically creates a pool for itself if you don't provide one.

"
Class {
	#name : #BlInfiniteRecyclerPool,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'scrap',
		'maxScrap',
		'attachCount'
	],
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #recycling }
BlInfiniteRecyclerPool >> at: anIntemType [
	<return: #BlInfiniteHolder or: nil>

	^ scrap at: anIntemType
		ifPresent: [ :aScrapHeap |
			aScrapHeap
				ifEmpty: [ nil ]
				ifNotEmpty: [ 
					| anIndex anElementHolder |
					anIndex := aScrapHeap size.
					anElementHolder := aScrapHeap at: anIndex.
					aScrapHeap removeAt: anIndex.
					anElementHolder ] ]
		ifAbsent: [ nil ]
]

{ #category : #'as yet unclassified' }
BlInfiniteRecyclerPool >> attach [
	attachCount := attachCount + 1
]

{ #category : #invalidate }
BlInfiniteRecyclerPool >> clear [
	scrap removeAll
]

{ #category : #initialization }
BlInfiniteRecyclerPool >> defaultMaxScrap [
	^ 50
]

{ #category : #'as yet unclassified' }
BlInfiniteRecyclerPool >> detach [
	attachCount := attachCount - 1
]

{ #category : #accessing }
BlInfiniteRecyclerPool >> heapAt: anItemType [
	<return: #OrderedCollection of: #BlInfiniteElementHolder>

	^ scrap
		at: anItemType
		ifAbsentPut: [ 
			| aHeap |
			aHeap := OrderedCollection new.
			maxScrap at: anItemType ifAbsentPut: [ self defaultMaxScrap ].
			aHeap ]
]

{ #category : #initialization }
BlInfiniteRecyclerPool >> initialize [
	super initialize.
	
	scrap := Dictionary new.
	maxScrap := Dictionary new.
	attachCount := 0.
]

{ #category : #recycling }
BlInfiniteRecyclerPool >> max: aNumber type: anItemType [
	| aScrapHeap |
	
	self
		assert: [ aNumber >= 0 ]
		description: [ 'Max amount of scrap must be non-negative' ].
	
	maxScrap at: anItemType put: aNumber.
	aScrapHeap := self heapAt: anItemType.
	
	[ aScrapHeap size > aNumber ] whileTrue: [
		aScrapHeap removeLast ]
]

{ #category : #recycling }
BlInfiniteRecyclerPool >> put: anElementHolder [
	| anItemType aScrapHeap |
	
	anItemType := anElementHolder itemType.
	aScrapHeap := self heapAt: anItemType.
	
	(maxScrap at: anItemType) <= aScrapHeap size
		ifTrue: [ ^ self ].
	
	self
		assert: [ (aScrapHeap includes: anElementHolder) not ]
		description: [ 'Scrap element already exists!' ].
	
	anElementHolder reset.
	aScrapHeap add: anElementHolder
]

{ #category : #accessing }
BlInfiniteRecyclerPool >> size [
	<return: #Number>

	^ scrap
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :aDictionary | aDictionary sumNumbers: [ :each | each size ] ]
]
