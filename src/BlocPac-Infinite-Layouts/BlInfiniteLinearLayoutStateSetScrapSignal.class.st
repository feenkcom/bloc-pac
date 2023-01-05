Class {
	#name : #BlInfiniteLinearLayoutStateSetScrapSignal,
	#superclass : #BlInfiniteLinearLayoutSignal,
	#instVars : [
		'scrapList'
	],
	#category : #'BlocPac-Infinite-Layouts-Signals'
}

{ #category : #initialization }
BlInfiniteLinearLayoutStateSetScrapSignal >> prepareForDelivery [
	super prepareForDelivery.

	scrapList := scrapList copy
]

{ #category : #accessing }
BlInfiniteLinearLayoutStateSetScrapSignal >> scrapList [

	^ scrapList
]

{ #category : #accessing }
BlInfiniteLinearLayoutStateSetScrapSignal >> scrapList: anObject [

	scrapList := anObject
]
