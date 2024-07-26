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

{ #category : #accessing }
BlInfiniteRecyclerAboutToRecycleInPoolSignal >> itemElement [
	^ self holder itemElement
]

{ #category : #initialization }
BlInfiniteRecyclerAboutToRecycleInPoolSignal >> prepareForDelivery [
	super prepareForDelivery.
	
	holderItemId := holder itemId.
	holderItemType := holder itemType
]

{ #category : #printing }
BlInfiniteRecyclerAboutToRecycleInPoolSignal >> printOneLineContentsOn: stream [
	holder ifNotNil: [
		stream print: self itemElement.
		stream space ].
	super printOneLineContentsOn: stream
]
