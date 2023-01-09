Class {
	#name : #BlInfiniteRecyclerFetcherResultSubStep,
	#superclass : #Object,
	#instVars : [
		'method',
		'message',
		'arguments'
	],
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #accessing }
BlInfiniteRecyclerFetcherResultSubStep >> arguments [

	^ arguments
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResultSubStep >> arguments: anObject [

	arguments := anObject
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResultSubStep >> formattedMessage [
	^ message format: (arguments ifNil: [ #() ])
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResultSubStep >> message [

	^ message
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResultSubStep >> message: anObject [

	message := anObject
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResultSubStep >> method [

	^ method
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResultSubStep >> method: anObject [

	method := anObject
]
