Class {
	#name : #BlInfiniteRecyclerAboutToBindHolderForPositionSignal,
	#superclass : #BlInfiniteRecyclerSignal,
	#instVars : [
		'position',
		'holder',
		'fetcherResult',
		'holderItemType',
		'holderItemId',
		'dataSourceItemType',
		'dataSourceItemId'
	],
	#category : #'BlocPac-Infinite-Signals'
}

{ #category : #accessing }
BlInfiniteRecyclerAboutToBindHolderForPositionSignal >> fetcherResult [

	^ fetcherResult
]

{ #category : #accessing }
BlInfiniteRecyclerAboutToBindHolderForPositionSignal >> fetcherResult: anObject [

	fetcherResult := anObject
]

{ #category : #accessing }
BlInfiniteRecyclerAboutToBindHolderForPositionSignal >> holder [

	^ holder
]

{ #category : #accessing }
BlInfiniteRecyclerAboutToBindHolderForPositionSignal >> holder: anObject [

	holder := anObject
]

{ #category : #accessing }
BlInfiniteRecyclerAboutToBindHolderForPositionSignal >> position [

	^ position
]

{ #category : #accessing }
BlInfiniteRecyclerAboutToBindHolderForPositionSignal >> position: anObject [

	position := anObject
]

{ #category : #initialization }
BlInfiniteRecyclerAboutToBindHolderForPositionSignal >> prepareForDelivery [
	super prepareForDelivery.
	
	holderItemId := holder itemId.
	holderItemType := holder itemType.
	dataSourceItemId := infiniteElement dataSource itemIdAt: position.
	dataSourceItemType := infiniteElement dataSource itemTypeAt: position
]
