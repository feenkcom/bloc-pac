Class {
	#name : #BlInfiniteChildBoundsBasedFinder,
	#superclass : #BlChildBoundsBasedFinder,
	#instVars : [
		'layout'
	],
	#category : #'BlocPac-Infinite-Layout'
}

{ #category : #accessing }
BlInfiniteChildBoundsBasedFinder >> childAt: anIndex [
	<return: #BlElement>
	
	^ layout childAt: anIndex
]

{ #category : #accessing }
BlInfiniteChildBoundsBasedFinder >> childAt: anIndex ifAbsent: anAbsentBlock [
	<return: #BlElement>
	
	^ layout childAt: anIndex ifAbsent: anAbsentBlock
]

{ #category : #accessing }
BlInfiniteChildBoundsBasedFinder >> layout [
	^ layout
]

{ #category : #accessing }
BlInfiniteChildBoundsBasedFinder >> layout: anObject [
	layout := anObject
]
