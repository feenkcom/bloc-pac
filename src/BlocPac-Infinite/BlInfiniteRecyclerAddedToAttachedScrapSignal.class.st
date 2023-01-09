Class {
	#name : #BlInfiniteRecyclerAddedToAttachedScrapSignal,
	#superclass : #BlInfiniteRecyclerSignal,
	#instVars : [
		'elementHolder',
		'flags'
	],
	#category : #'BlocPac-Infinite-Signals'
}

{ #category : #accessing }
BlInfiniteRecyclerAddedToAttachedScrapSignal >> elementHolder [

	^ elementHolder
]

{ #category : #accessing }
BlInfiniteRecyclerAddedToAttachedScrapSignal >> elementHolder: anObject [

	elementHolder := anObject
]

{ #category : #initialization }
BlInfiniteRecyclerAddedToAttachedScrapSignal >> prepareForDelivery [
	super prepareForDelivery.

	flags := elementHolder flags copy
]
