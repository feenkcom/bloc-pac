Class {
	#name : #BlInfiniteRecyclerAddedToChangedScrapSignal,
	#superclass : #BlInfiniteRecyclerSignal,
	#instVars : [
		'elementHolder',
		'flags'
	],
	#category : #'BlocPac-Infinite-Signals'
}

{ #category : #accessing }
BlInfiniteRecyclerAddedToChangedScrapSignal >> elementHolder [

	^ elementHolder
]

{ #category : #accessing }
BlInfiniteRecyclerAddedToChangedScrapSignal >> elementHolder: anObject [

	elementHolder := anObject
]

{ #category : #initialization }
BlInfiniteRecyclerAddedToChangedScrapSignal >> prepareForDelivery [
	super prepareForDelivery.

	flags := elementHolder flags copy
]
