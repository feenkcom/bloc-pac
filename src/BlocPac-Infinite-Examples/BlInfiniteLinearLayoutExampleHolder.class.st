Class {
	#name : #BlInfiniteLinearLayoutExampleHolder,
	#superclass : #BlInfiniteHolder,
	#category : #'BlocPac-Infinite-Examples'
}

{ #category : #accessing }
BlInfiniteLinearLayoutExampleHolder >> color: aColor [
	itemElement background: aColor
]

{ #category : #accessing }
BlInfiniteLinearLayoutExampleHolder >> constraintsDo: aBlock [
	itemElement constraintsDo: aBlock
]

{ #category : #initialization }
BlInfiniteLinearLayoutExampleHolder >> initialize [
	super initialize.
	
	itemElement := BlElement new.
	itemElement size: 0@0
]

{ #category : #accessing }
BlInfiniteLinearLayoutExampleHolder >> itemDo: aBlock [
	aBlock value: itemElement
]
