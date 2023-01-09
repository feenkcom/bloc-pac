Class {
	#name : #BlInfiniteRecyclerFetcherResult,
	#superclass : #Object,
	#instVars : [
		'holder',
		'isFromScrap'
	],
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #testing }
BlInfiniteRecyclerFetcherResult >> hasHolder [
	^ holder notNil
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResult >> holder [
	^ holder
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResult >> holder: anElementHolder fromScrap: isHolderFromScrap [
	holder := anElementHolder.
	isFromScrap := isHolderFromScrap
]

{ #category : #initialization }
BlInfiniteRecyclerFetcherResult >> initialize [
	super initialize.
	
	isFromScrap := false
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResult >> isFromScrap [
	^ isFromScrap
]

{ #category : #'api - recording' }
BlInfiniteRecyclerFetcherResult >> recordFetcher: aRecyclerFetcher [
]

{ #category : #'api - recording' }
BlInfiniteRecyclerFetcherResult >> recordFetcherStep: aMessageOrBlockClosure [
]

{ #category : #'api - recording' }
BlInfiniteRecyclerFetcherResult >> recordFetcherStep: aMessage arguments: theArguments [
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResult >> removeHolder [
	holder := nil.
	isFromScrap := false
]
