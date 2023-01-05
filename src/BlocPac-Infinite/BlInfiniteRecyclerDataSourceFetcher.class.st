Class {
	#name : #BlInfiniteRecyclerDataSourceFetcher,
	#superclass : #BlInfiniteRecyclerFetcher,
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #initialization }
BlInfiniteRecyclerDataSourceFetcher >> defaultNext [
	^ nil
]

{ #category : #'element fetching' }
BlInfiniteRecyclerDataSourceFetcher >> doFetchElementHolderFor: aFetcherContext [
	| aRecyclerController itemType holder |

	aRecyclerController := aFetcherContext recyclerController.

	itemType := aFetcherContext itemType.

	holder := aRecyclerController createElementHolderOfType: itemType.
	holder ifNil: [ self error: 'Data source must not return nil holder!' ].
	
	aFetcherContext
		recordFetcherStep: 'Created new holder (index = {1}, type = {2})'
		arguments: [ { aFetcherContext itemPosition . itemType } ].
	
	aFetcherContext
		holder: holder
		fromScrap: false
]
