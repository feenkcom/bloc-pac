Class {
	#name : #BlInfiniteRecyclerFetcherLoggingResult,
	#superclass : #BlInfiniteRecyclerFetcherResult,
	#instVars : [
		'steps'
	],
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #initialization }
BlInfiniteRecyclerFetcherLoggingResult >> initialize [
	super initialize.

	steps := OrderedCollection new
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherLoggingResult >> isFromScrap [
	^ isFromScrap
]

{ #category : #'api - recording' }
BlInfiniteRecyclerFetcherLoggingResult >> recordFetcher: aRecyclerFetcher [
	steps add: (BlInfiniteRecyclerFetcherResultStep new recyclerFetcher: aRecyclerFetcher)
]

{ #category : #'api - recording' }
BlInfiniteRecyclerFetcherLoggingResult >> recordFetcherStep: aMessageOrBlockClosure [
	steps last recordSubStep: (BlInfiniteRecyclerFetcherResultSubStep new
		method: self whichMethod;
		message: aMessageOrBlockClosure value)
]

{ #category : #'api - recording' }
BlInfiniteRecyclerFetcherLoggingResult >> recordFetcherStep: aMessage arguments: theArguments [
	steps last recordSubStep: (BlInfiniteRecyclerFetcherResultSubStep new
		method: self whichMethod;
		message: aMessage value;
		arguments: theArguments value)
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherLoggingResult >> removeHolder [
	holder := nil.
	isFromScrap := false
]

{ #category : #'private - recording' }
BlInfiniteRecyclerFetcherLoggingResult >> whichMethod [
	^ thisContext
		"recordFetcherStep:*"
		sender
		"fetcher context"
		sender
		"fetcher method"
		sender
		compiledCode
]
