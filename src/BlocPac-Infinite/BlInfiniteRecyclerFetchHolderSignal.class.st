Class {
	#name : #BlInfiniteRecyclerFetchHolderSignal,
	#superclass : #BlInfiniteRecyclerSignal,
	#instVars : [
		'fetcherContext',
		'fetcherResult',
		'position'
	],
	#category : #'BlocPac-Infinite-Signals'
}

{ #category : #accessing }
BlInfiniteRecyclerFetchHolderSignal >> fetcherContext [

	^ fetcherContext
]

{ #category : #accessing }
BlInfiniteRecyclerFetchHolderSignal >> fetcherContext: anObject [

	fetcherContext := anObject
]

{ #category : #accessing }
BlInfiniteRecyclerFetchHolderSignal >> fetcherResult [
	<return: #BlInfiniteRecyclerFetcherResult>

	^ fetcherResult
]

{ #category : #accessing }
BlInfiniteRecyclerFetchHolderSignal >> fetcherResult: anObject [
	fetcherResult := anObject
]

{ #category : #accessing }
BlInfiniteRecyclerFetchHolderSignal >> position [

	^ position
]

{ #category : #accessing }
BlInfiniteRecyclerFetchHolderSignal >> position: anObject [

	position := anObject
]

{ #category : #initialization }
BlInfiniteRecyclerFetchHolderSignal >> prepareForDelivery [
	super prepareForDelivery.
	
	fetcherContext shouldLog: true
]

{ #category : #printing }
BlInfiniteRecyclerFetchHolderSignal >> printOneLineContentsOn: aStream [
	self fetcherResult hasHolder
		ifTrue: [
			self fetcherResult isFromScrap
				ifTrue: [ aStream nextPutAll: 'Recycled holder from scrap' ]
				ifFalse: [ aStream nextPutAll: 'Created new holder or acquired it from the pool' ] ]
		ifFalse: [ aStream nextPutAll: 'Holder not found' ]
]
