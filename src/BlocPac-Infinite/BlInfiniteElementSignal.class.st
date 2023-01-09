Class {
	#name : #BlInfiniteElementSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'infiniteElement'
	],
	#category : #'BlocPac-Infinite-Signals'
}

{ #category : #accessing }
BlInfiniteElementSignal >> element [
	^ self infiniteElement
]

{ #category : #testing }
BlInfiniteElementSignal >> hasParentSuchThat: aBlock [
	^ infiniteElement
		withAllParentsDetect: aBlock
		ifFound: [ :aParent | true ]
		ifNone: [ false ]
]

{ #category : #accessing }
BlInfiniteElementSignal >> infiniteElement [

	^ infiniteElement
]

{ #category : #accessing }
BlInfiniteElementSignal >> infiniteElement: anObject [

	infiniteElement := anObject
]
