Class {
	#name : #BlInfiniteRecyclerStableScrapFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #private }
BlInfiniteRecyclerStableScrapFetcher >> attachedScrapForId: anItemId type: anItemType context: aFetcherContext [
	| aRecyclerController |
	
	aRecyclerController := aFetcherContext recyclerController.
	
	aRecyclerController attachedScrap reverseWithIndexDo: [ :eachElementHolder :eachIndex |
		(eachElementHolder itemId = anItemId and: [ eachElementHolder wasReturnedFromScrap not ]) ifTrue: [ 
			anItemType = eachElementHolder itemType
				ifTrue: [ 
					eachElementHolder flags addReturnedFromScrap.
					(eachElementHolder isRemoved and: [ aRecyclerController isPreLayout not ]) ifTrue: [ 
						eachElementHolder flags
							addUpdate;
							clearInvalid;
							clearRemoved ].
					aFetcherContext
						recordFetcherStep: 'Found in attached scrap (id = {1}, type = {2}).'
						arguments: [ { anItemId . anItemType } ].
					aFetcherContext holder: eachElementHolder fromScrap: true.
					^ self ]
				ifFalse: [
					 aFetcherContext isDryRun ifFalse: [
						"if we are running animations, it is actually better to keep it in scrap
						but this would force layout to lay it out which would be bad.
						Recycle this scrap. Type mismatch."
						aRecyclerController attachedScrap removeAt: eachIndex.
						aFetcherContext recyclerController infiniteElement
							removeDetachedChild: eachElementHolder itemElement
							animate: false.
						aRecyclerController quickRecycleScrap: eachElementHolder itemElement ] ] ] ]
]

{ #category : #private }
BlInfiniteRecyclerStableScrapFetcher >> cachedScrapForId: anItemId type: anItemType context: aFetcherContext [
	| aRecyclerController |
	
	aRecyclerController := aFetcherContext recyclerController.
	aRecyclerController cachedScrap reverseWithIndexDo: [ :eachElementHolder :eachIndex |
		(eachElementHolder itemId = anItemId and: [ eachElementHolder isAttachedToTransitionOverlay not ]) ifTrue: [ 
			(eachElementHolder itemType = anItemType)
				ifTrue: [
					aFetcherContext isDryRun
						ifFalse: [ aRecyclerController cachedScrap removeAt: eachIndex ].
					aFetcherContext
						recordFetcherStep: 'Found in cached scrap (id = {1}, type = {2}).'
						arguments: [ { anItemId . anItemType } ].
					aFetcherContext holder: eachElementHolder fromScrap: true.
					^ self ]
				ifFalse: [
					aFetcherContext isDryRun
						ifFalse: [
							aRecyclerController recycleCachedElementAt: eachIndex.
							^ self ] ] ] ].
			
	aFetcherContext
		recordFetcherStep: 'No element holder for a given type and id in the cached scrap'.
]

{ #category : #initialization }
BlInfiniteRecyclerStableScrapFetcher >> defaultNext [
	^ BlInfiniteRecyclerUserCacheFetcher instance
]

{ #category : #'element fetching' }
BlInfiniteRecyclerStableScrapFetcher >> doFetchElementHolderFor: aFetcherContext [
	| aRecyclerController |
	
	aRecyclerController := aFetcherContext recyclerController.
	aRecyclerController hasStableIds
		ifFalse: [
			aFetcherContext recordFetcherStep: 'Stable ids are not enabled'.
			^ self ].
	
	self
		stableScrapForId: aFetcherContext itemId
		type: aFetcherContext itemType
		context: aFetcherContext.
		
	aFetcherContext hasHolder
		ifFalse: [ ^ self ].
		
	aFetcherContext holder
		position: aFetcherContext itemPosition
]

{ #category : #private }
BlInfiniteRecyclerStableScrapFetcher >> stableScrapForId: anItemId type: anItemType context: aFetcherContext [

	"Look in our attached elements first"
	self
		attachedScrapForId: anItemId
		type: anItemType
		context: aFetcherContext.
	
	aFetcherContext hasHolder
		ifTrue: [ ^ self ].

	"Search the first-level cache"
	self
		cachedScrapForId: anItemId
		type: anItemType
		context: aFetcherContext
]
