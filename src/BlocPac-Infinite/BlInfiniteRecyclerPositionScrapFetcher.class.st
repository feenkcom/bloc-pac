Class {
	#name : #BlInfiniteRecyclerPositionScrapFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #private }
BlInfiniteRecyclerPositionScrapFetcher >> attachedScrapFor: aFetcherContext [
	"Try first for an exact, non-invalid match from attached scrap."

	aFetcherContext recyclerController attachedScrap 
		detect: [ :holder | (holder wasReturnedFromScrap not
			and: [ holder layoutPosition = aFetcherContext layoutPosition 
				and: [ holder isInvalid not
					and: [ (aFetcherContext recyclerController isPreLayout
						or: [ holder isRemoved not ]) ] ] ]) ]
		ifFound: [ :holder | 
			holder flags addReturnedFromScrap.
			
			aFetcherContext
				recordFetcherStep: 'Found in attached scrap (size = {1})'
				arguments: [
					{
						aFetcherContext recyclerController attachedScrap size.
						holder itemId
					} ].
			
			aFetcherContext
				holder: holder
				fromScrap: true ]
		ifNone: [
			aFetcherContext
				recordFetcherStep: 'Not in attached scrap (size = {1})'
				arguments: [ { aFetcherContext recyclerController attachedScrap size } ] ]
]

{ #category : #private }
BlInfiniteRecyclerPositionScrapFetcher >> cachedScrapFor: aFetcherContext [
	aFetcherContext recyclerController cachedScrap withIndexDo: [ :anElementHolder :index |
		(anElementHolder wasReturnedFromScrap not and: [
			anElementHolder layoutPosition = aFetcherContext layoutPosition and: [
				anElementHolder isAttachedToTransitionOverlay not ] ])
			ifTrue: [ 

				aFetcherContext isDryRun
					ifFalse: [ aFetcherContext recyclerController cachedScrap removeAt: index ].

				^ aFetcherContext
					holder: anElementHolder
					fromScrap: true ] ].

	aFetcherContext
		recordFetcherStep: 'Not in cached scrap (size = {1})'
		arguments: [ { aFetcherContext recyclerController cachedScrap size } ]
]

{ #category : #initialization }
BlInfiniteRecyclerPositionScrapFetcher >> defaultNext [
	^ BlInfiniteRecyclerStableScrapFetcher instance
]

{ #category : #'element fetching' }
BlInfiniteRecyclerPositionScrapFetcher >> doFetchElementHolderFor: aFetcherContext [
	| anElementHolder |

	self positionedScrapFor: aFetcherContext.	
	aFetcherContext hasHolder
		ifFalse: [ ^ self ].

	(self validateHolder: aFetcherContext holder controller: aFetcherContext recyclerController)
		ifTrue: [ ^ true ].

	anElementHolder := aFetcherContext holder.
	
	aFetcherContext isDryRun ifFalse: [ 
		anElementHolder flags addInvalid.
		anElementHolder isScrap
			ifTrue: [ 
				aFetcherContext recyclerController infiniteElement
					removeDetachedChild: anElementHolder itemElement
					animate: false.
				anElementHolder unscrap ]
			ifFalse: [ anElementHolder wasReturnedFromScrap
				ifTrue: [ anElementHolder clearReturnedFromScrap ] ].
			aFetcherContext recyclerController privateRecycleElementHolder: anElementHolder ].

	aFetcherContext
		recordFetcherStep: 'Found view holder can not be used for a position.'.	
	aFetcherContext removeHolder
]

{ #category : #private }
BlInfiniteRecyclerPositionScrapFetcher >> hiddenNonRemovedScrapFor: aFetcherContext [
	| aChildManager |

	aFetcherContext isDryRun
		ifTrue: [
			^ aFetcherContext
				recordFetcherStep: 'Hidden non-removed scrap search is disabled for dry runs' ].

	aChildManager := aFetcherContext childrenManager.
	"This View is good to be used. We just need to unhide, detach and move to the scrap list."
	(aChildManager findHiddenNonRemovedChildAt: aFetcherContext layoutPosition)
		ifNotNil: [ :aChildElement | 
			| anElementHolder aLayoutIndex |
			"This View is good to be used. We just need to unhide, detach and move to the scrap list."
			anElementHolder := aFetcherContext recyclerController
					elementHolderOf: aChildElement.
			aChildManager unhide: aChildElement.
			aLayoutIndex := aChildManager childIndexOf: aChildElement.
			aLayoutIndex isZero
				ifTrue: [ self error: 'Layout index must not be 0 after unhiding an element' ].

			aChildManager detachChildAt: aLayoutIndex.
			aFetcherContext recyclerController scrapElement: aChildElement.
			anElementHolder flags
				addReturnedFromScrap;
				addBouncedFromHiddenList.

			aFetcherContext holder: anElementHolder fromScrap: true ]
]

{ #category : #private }
BlInfiniteRecyclerPositionScrapFetcher >> positionedScrapFor: aFetcherContext [

	self attachedScrapFor: aFetcherContext.
	aFetcherContext hasHolder
		ifTrue: [ ^ self ].

	self hiddenNonRemovedScrapFor: aFetcherContext.
	aFetcherContext hasHolder
		ifTrue: [ ^ self ].
		
	self cachedScrapFor: aFetcherContext.
]

{ #category : #private }
BlInfiniteRecyclerPositionScrapFetcher >> validateHolder: aHolder controller: aRecyclerController [
	"Checks whether a given view holder can be used for the provided position.
	Returns true if ViewHolder matches the provided position, false otherwise"
	<return: #Boolean>

	aHolder isRemoved ifTrue: [ 
		aRecyclerController isPreLayout
			ifFalse: [ Error signal: 'Should not get a removed holder unless it is pre-layout!' ].
		^ aRecyclerController isPreLayout ].

	(aHolder position <= 0 or: [ aHolder position > aRecyclerController dataSourceItemCount ])
		ifTrue: [ Error signal: ('Holder has completely wrong position! position = {1}, count = {2}'
			format: { aHolder position. aRecyclerController dataSourceItemCount. }) ].

	aRecyclerController isPreLayout ifFalse: [ 
		| type |
		type := aRecyclerController itemTypeAt: aHolder position.
		type = aHolder itemType
			ifFalse: [ ^ false ] ].

	^ aRecyclerController hasStableIds
		ifTrue: [ aHolder itemId = (aRecyclerController itemIdAt: aHolder position) ]
		ifFalse: [ true ]
]
