Class {
	#name : #BlInfiniteExampleMockedRecyclerController,
	#superclass : #Object,
	#instVars : [
		'isPreLayout',
		'changedScrap',
		'attachedScrap',
		'cachedScrap',
		'hasStableIds',
		'userCache',
		'recyclerPool'
	],
	#category : #'BlocPac-Infinite-Examples'
}

{ #category : #accessing }
BlInfiniteExampleMockedRecyclerController >> attachedScrap [

	^ attachedScrap
]

{ #category : #accessing }
BlInfiniteExampleMockedRecyclerController >> attachedScrap: anObject [

	attachedScrap := anObject
]

{ #category : #accessing }
BlInfiniteExampleMockedRecyclerController >> cachedScrap [

	^ cachedScrap
]

{ #category : #accessing }
BlInfiniteExampleMockedRecyclerController >> cachedScrap: anObject [

	cachedScrap := anObject
]

{ #category : #accessing }
BlInfiniteExampleMockedRecyclerController >> changedScrap [

	^ changedScrap
]

{ #category : #accessing }
BlInfiniteExampleMockedRecyclerController >> changedScrap: anObject [

	changedScrap := anObject
]

{ #category : #'as yet unclassified' }
BlInfiniteExampleMockedRecyclerController >> computePositionOffset: anInteger [ 
	^ anInteger
]

{ #category : #'as yet unclassified' }
BlInfiniteExampleMockedRecyclerController >> dataSourceItemCount [
	^ SmallInteger maxVal
]

{ #category : #testing }
BlInfiniteExampleMockedRecyclerController >> hasChangedScrap [
	^ changedScrap notEmpty
]

{ #category : #'as yet unclassified' }
BlInfiniteExampleMockedRecyclerController >> hasStableIds [
	^ hasStableIds
]

{ #category : #accessing }
BlInfiniteExampleMockedRecyclerController >> hasStableIds: aBoolean [
	hasStableIds := aBoolean
]

{ #category : #initialization }
BlInfiniteExampleMockedRecyclerController >> initialize [
	super initialize.
	
	isPreLayout := false.
	hasStableIds := false.
	
	changedScrap := #().
	attachedScrap := #().
	cachedScrap := #().
	
	recyclerPool := BlInfiniteRecyclerPool new
]

{ #category : #accessing }
BlInfiniteExampleMockedRecyclerController >> isPreLayout [
	^ isPreLayout
]

{ #category : #accessing }
BlInfiniteExampleMockedRecyclerController >> isPreLayout: aBoolean [
	 isPreLayout := aBoolean
]

{ #category : #'as yet unclassified' }
BlInfiniteExampleMockedRecyclerController >> itemIdAt: anInteger [ 
	^ 0
]

{ #category : #'as yet unclassified' }
BlInfiniteExampleMockedRecyclerController >> itemTypeAt: anInteger [ 
	^ BlInfiniteItemType invalid
]

{ #category : #'as yet unclassified' }
BlInfiniteExampleMockedRecyclerController >> recyclerPool [
	^ recyclerPool
]

{ #category : #'as yet unclassified' }
BlInfiniteExampleMockedRecyclerController >> userCache [
	^ userCache
]
