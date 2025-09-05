Class {
	#name : #BlInfiniteElementSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'infiniteElement'
	],
	#category : #'BlocPac-Infinite-Signals'
}

{ #category : #testing }
BlInfiniteElementSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

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
