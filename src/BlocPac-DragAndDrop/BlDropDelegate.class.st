Class {
	#name : #BlDropDelegate,
	#superclass : #Object,
	#instVars : [
		'acceptConditions'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #accessing }
BlDropDelegate >> acceptConditions [
	^ acceptConditions
]

{ #category : #accessing }
BlDropDelegate >> acceptConditions: aCollectionOfBlockClosures [
	acceptConditions := aCollectionOfBlockClosures
]

{ #category : #accessing }
BlDropDelegate >> dragged: aDragContainerElement items: aCollectionOfDragItems at: aPosition offset: anOffset in: anElement [
	| doesAccept |

	doesAccept := aCollectionOfDragItems anySatisfy:  [ :eachDragItem | self shouldAccept: eachDragItem in: anElement ].
	doesAccept ifFalse: [ ^ self ].
	anElement dispatchEvent: (BlItemsDraggedEvent new
		dragContainer: aDragContainerElement;
		items: aCollectionOfDragItems;
		position: (anElement globalPointToLocal: aPosition);
		offset: anOffset)
]

{ #category : #accessing }
BlDropDelegate >> drop: aCollectionOfDragItems at: aPosition in: anElement [
	| rejectedItems acceptedItems |

	rejectedItems := OrderedCollection new.
	acceptedItems := OrderedCollection new.
	
	aCollectionOfDragItems do: [ :eachDragItem |
		(self shouldAccept: eachDragItem in: anElement)
			ifTrue: [ acceptedItems add: eachDragItem ]
			ifFalse: [ rejectedItems add: eachDragItem ] ].

	acceptedItems do: [ :eachDragItem | eachDragItem sourceElement dispatchEvent: (BlAboutToBeDroppedEvent new dropTarget: anElement) ].
	
	acceptedItems do: [ :each |
		each sourceElement states
			removeState: BlElementDraggingState uniqueInstance ].

	anElement dispatchEvent: (BlItemsDroppedEvent new
		items: acceptedItems;
		position: (anElement globalPointToLocal: aPosition)).

	^ rejectedItems asArray
]

{ #category : #accessing }
BlDropDelegate >> enter: aCollectionOfDragItems at: aPosition in: anElement [
	| doesAccept |
	
	doesAccept := aCollectionOfDragItems anySatisfy:  [ :eachDragItem | self shouldAccept: eachDragItem in: anElement ].
	
	anElement dispatchEvent: (BlItemsEnteredEvent new
		items: aCollectionOfDragItems;
		position: (anElement globalPointToLocal: aPosition);
		mayAcceptItems: doesAccept)
]

{ #category : #accessing }
BlDropDelegate >> shouldAccept: aDragItem in: anElement [
	^ acceptConditions allSatisfy: [ :eachCondition | eachCondition cull: aDragItem cull: anElement ]
]
