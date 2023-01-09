Class {
	#name : #BlInfiniteRecyclerUserCacheFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #initialization }
BlInfiniteRecyclerUserCacheFetcher >> defaultNext [
	^ BlInfiniteRecyclerPoolFetcher instance
]

{ #category : #'element fetching' }
BlInfiniteRecyclerUserCacheFetcher >> doFetchElementHolderFor: aFetcherContext [
	| aRecyclerController anElementHolder element |

	aRecyclerController := aFetcherContext recyclerController.
	
	aRecyclerController userCache ifNil: [
		aFetcherContext recordFetcherStep: 'No user cache'.
		^ self ].
	
	"We are NOT sending the #itemPosition because Layout does not know it."
	element := aRecyclerController userCache
		elementFor: aRecyclerController recycler
		at: aFetcherContext position
		type: aFetcherContext itemType.

	element ifNotNil: [ :anElement |
		anElementHolder := aRecyclerController elementHolderOf: anElement.
		anElementHolder ifNil: [ self error: 'Returned by custom cache element must have Holder!' ].
		anElementHolder shouldIgnore ifTrue: [ self error: 'Element can not be in ignore mode! You need to remove #ignore flag first' ].
		
		aFetcherContext
			holder: anElement
			fromScrap: false ]
]
