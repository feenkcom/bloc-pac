Class {
	#name : #BlInfiniteRecyclerPoolFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #initialization }
BlInfiniteRecyclerPoolFetcher >> defaultNext [
	^ BlInfiniteRecyclerDataSourceFetcher instance
]

{ #category : #'element fetching' }
BlInfiniteRecyclerPoolFetcher >> doFetchElementHolderFor: aFetcherContext [
	| aRecyclerController holder |
	
	aRecyclerController := aFetcherContext recyclerController.
	
	holder := aRecyclerController recyclerPool at: aFetcherContext itemType.
	holder ifNil: [
		aFetcherContext recordFetcherStep: 'No element holder for a given type in the recycler pool'.
		^ self ].

	holder reset.
	
	aFetcherContext
		holder: holder
		fromScrap: false
]
