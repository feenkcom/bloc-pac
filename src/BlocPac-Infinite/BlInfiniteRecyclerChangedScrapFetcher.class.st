Class {
	#name : #BlInfiniteRecyclerChangedScrapFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #private }
BlInfiniteRecyclerChangedScrapFetcher >> changedScrapFor: aFetcherContext [	
	aFetcherContext recyclerController changedScrap
		detect: [ :eachHolder |
			eachHolder wasReturnedFromScrap not and: [ eachHolder layoutPosition = aFetcherContext layoutPosition ] ]
		ifFound: [ :eachHolder |
			eachHolder flags addReturnedFromScrap.
			aFetcherContext
				recordFetcherStep: 'Found in changed scrap by layout position';
				holder: eachHolder
				fromScrap: true ]
		ifNone: [ aFetcherContext recordFetcherStep: 'Not in changed scrap by layout position' ]
]

{ #category : #initialization }
BlInfiniteRecyclerChangedScrapFetcher >> defaultNext [
	^ BlInfiniteRecyclerPositionScrapFetcher instance
]

{ #category : #'element fetching' }
BlInfiniteRecyclerChangedScrapFetcher >> doFetchElementHolderFor: aFetcherContext [	
	aFetcherContext recyclerController isPreLayout
		ifFalse: [ ^ aFetcherContext recordFetcherStep: 'Not in pre-layout' ].

	aFetcherContext recyclerController hasChangedScrap
		ifFalse: [ ^ aFetcherContext recordFetcherStep: 'There is no changed scrap' ].

	self changedScrapFor: aFetcherContext.
	
	aFetcherContext hasHolder
		ifTrue: [ ^ self ].

	self idScrapFor: aFetcherContext
]

{ #category : #private }
BlInfiniteRecyclerChangedScrapFetcher >> idScrapFor: aFetcherContext [
	| aRecyclerController anItemId |
	
	aRecyclerController := aFetcherContext recyclerController.
	
	aRecyclerController hasStableIds
		ifFalse: [
			aFetcherContext recordFetcherStep: 'Stable ids not enabled'.
			^ self ].
	
	anItemId := aFetcherContext itemId.
	aRecyclerController changedScrap
		detect: [ :holder |
			holder wasReturnedFromScrap not and: [ holder itemId = anItemId ] ]
		ifFound: [ :holder |
			holder flags addReturnedFromScrap.
			
			aFetcherContext
				recordFetcherStep: 'Found in changed scrap by id = {1}'
				arguments: [ { anItemId } ].
			
			aFetcherContext holder: holder fromScrap: true ]
		ifNone: [
			aFetcherContext
				recordFetcherStep: 'Not in changed scrap (by id)' ]
]
