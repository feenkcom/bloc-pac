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
BlInfiniteRecyclerFetchHolderSignal >> itemElement [
	^ fetcherResult ifNotNil: [ :aResult | aResult holder ifNotNil: #itemElement ]
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

	(fetcherResult isNotNil and: [ fetcherResult hasHolder ])
		ifTrue: [
			self fetcherResult isFromScrap
				ifTrue: [ aStream nextPutAll: 'Recycled holder from scrap' ]
				ifFalse: [ aStream nextPutAll: 'Created new holder or acquired it from the pool' ].
				
			aStream space; nextPutAll: 'at position: '; print: self position.
			aStream space; print: self itemElement. ]
		ifFalse: [ aStream nextPutAll: 'Holder not found' ]
]
