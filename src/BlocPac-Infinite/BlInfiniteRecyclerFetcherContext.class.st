Class {
	#name : #BlInfiniteRecyclerFetcherContext,
	#superclass : #Object,
	#instVars : [
		'position',
		'recyclerController',
		'shouldLog',
		'result',
		'cachedItemPosition',
		'cachedItemType',
		'cachedItemId'
	],
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #accessing }
BlInfiniteRecyclerFetcherContext >> cachedItemId: anObject [

	cachedItemId := anObject
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherContext >> childrenManager [
	<return: #BlInfiniteChildrenManager>
	
	^ self recyclerController childrenManager
]

{ #category : #'api - result' }
BlInfiniteRecyclerFetcherContext >> hasHolder [
	^ result hasHolder
]

{ #category : #'api - result' }
BlInfiniteRecyclerFetcherContext >> holder [
	^ result holder
]

{ #category : #'api - result' }
BlInfiniteRecyclerFetcherContext >> holder: anElementHolder fromScrap: isFromScrap [
	result
		holder: anElementHolder
		fromScrap: isFromScrap
]

{ #category : #initialization }
BlInfiniteRecyclerFetcherContext >> initialize [
	super initialize.
	
	shouldLog := false
]

{ #category : #'api - accessing' }
BlInfiniteRecyclerFetcherContext >> itemId [
	^ cachedItemId ifNil: [ cachedItemId := recyclerController itemIdAt: self itemPosition ]
]

{ #category : #'api - accessing' }
BlInfiniteRecyclerFetcherContext >> itemPosition [
	^ cachedItemPosition ifNil: [
		| aDataSourcePosition |
		
		aDataSourcePosition := recyclerController computePositionOffset: self layoutPosition.

		(aDataSourcePosition < 1 or: [ aDataSourcePosition > recyclerController dataSourceItemCount ])
			ifTrue: [ Error signal: 'Wrong item position!' ].

		cachedItemPosition := aDataSourcePosition ]
]

{ #category : #'api - accessing' }
BlInfiniteRecyclerFetcherContext >> itemType [
	^ cachedItemType ifNil: [ cachedItemType := recyclerController itemTypeAt: self itemPosition ]
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherContext >> layoutPosition [
	^ position
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherContext >> layoutPosition: anObject [
	position := anObject
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherContext >> position [

	^ position
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherContext >> position: anObject [

	position := anObject
]

{ #category : #'api - recording' }
BlInfiniteRecyclerFetcherContext >> recordFetcher: aRecyclerFetcher [
	result recordFetcher: aRecyclerFetcher
]

{ #category : #'api - recording' }
BlInfiniteRecyclerFetcherContext >> recordFetcherStep: aMessage [
	result
		recordFetcherStep: aMessage
]

{ #category : #'api - recording' }
BlInfiniteRecyclerFetcherContext >> recordFetcherStep: aMessage arguments: theArguments [
	result
		recordFetcherStep: aMessage
		arguments: theArguments
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherContext >> recyclerController [

	^ recyclerController
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherContext >> recyclerController: anObject [

	recyclerController := anObject
]

{ #category : #'api - result' }
BlInfiniteRecyclerFetcherContext >> removeHolder [
	result removeHolder
]

{ #category : #'api - result' }
BlInfiniteRecyclerFetcherContext >> result: aFetcherResult [
	result := aFetcherResult
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherContext >> shouldLog [

	^ shouldLog
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherContext >> shouldLog: anObject [

	shouldLog := anObject
]

{ #category : #'api - result' }
BlInfiniteRecyclerFetcherContext >> takeResult [
	| aResult |
	
	aResult := result.
	result := nil.
	^ aResult
]
