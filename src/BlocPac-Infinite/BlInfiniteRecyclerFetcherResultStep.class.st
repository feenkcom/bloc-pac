Class {
	#name : #BlInfiniteRecyclerFetcherResultStep,
	#superclass : #Object,
	#instVars : [
		'recyclerFetcher',
		'substeps'
	],
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #'api - recording' }
BlInfiniteRecyclerFetcherResultStep >> recordSubStep: aSubStep [
	substeps ifNil: [ substeps := OrderedCollection new ].
	substeps add: aSubStep
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResultStep >> recyclerFetcher [

	^ recyclerFetcher
]

{ #category : #accessing }
BlInfiniteRecyclerFetcherResultStep >> recyclerFetcher: anObject [

	recyclerFetcher := anObject
]
