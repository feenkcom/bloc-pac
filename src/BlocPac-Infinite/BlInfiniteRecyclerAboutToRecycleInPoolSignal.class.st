Class {
	#name : #BlInfiniteRecyclerAboutToRecycleInPoolSignal,
	#superclass : #BlInfiniteRecyclerSignal,
	#instVars : [
		'holder',
		'holderItemType',
		'holderItemId'
	],
	#category : #'BlocPac-Infinite-Signals'
}

{ #category : #accessing }
BlInfiniteRecyclerAboutToRecycleInPoolSignal >> holder [

	^ holder
]

{ #category : #accessing }
BlInfiniteRecyclerAboutToRecycleInPoolSignal >> holder: anObject [

	holder := anObject
]

{ #category : #initialization }
BlInfiniteRecyclerAboutToRecycleInPoolSignal >> prepareForDelivery [
	super prepareForDelivery.
	
	holderItemId := holder itemId.
	holderItemType := holder itemType
]
