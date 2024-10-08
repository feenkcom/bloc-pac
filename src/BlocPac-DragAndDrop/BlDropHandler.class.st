Class {
	#name : #BlDropHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'itemsDroppedAction',
		'acceptConditions',
		'itemsDraggedAction',
		'itemsDragLeftAction',
		'itemsDragEnteredAction'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #accessing }
BlDropHandler >> acceptDomainObjectsSuchThat: aBlock [
	self acceptItemsSuchThat: [ :aDragItem :aDropArea | aBlock value: aDragItem domainObject ]
]

{ #category : #accessing }
BlDropHandler >> acceptItemsSuchThat: aBlock [
	acceptConditions add: aBlock
]

{ #category : #accessing }
BlDropHandler >> acceptOnlyFromThisElement [
	self acceptItemsSuchThat: [ :aDragItem :aDropArea | aDragItem sourceElement parent == aDropArea ]
]

{ #category : #accessing }
BlDropHandler >> createDropDelegate [
	^ BlDropDelegate new acceptConditions: acceptConditions
]

{ #category : #accessing }
BlDropHandler >> dragEnterEvent: aDropEnterEvent [
	| aSpaceDropEnterEvent |
	
	aSpaceDropEnterEvent := BlSpaceDragDropEnterEvent new
			element: aDropEnterEvent currentTarget;
			delegate: self createDropDelegate;
			position: aDropEnterEvent position.

	aDropEnterEvent currentTarget space dispatchEvent: aSpaceDropEnterEvent
]

{ #category : #accessing }
BlDropHandler >> dragEvent: aDragEvent [
	
	(aDragEvent currentTarget bounds inLocal asRectangle
		containsPoint: aDragEvent localPosition)
			ifFalse: [ ^ self ].

	aDragEvent consumed: true.
	
	aDragEvent currentTarget space dispatchEvent: (BlSpaceDragDraggedEvent new
		element: aDragEvent currentTarget;
		delegate: self createDropDelegate;
		position: aDragEvent position)
]

{ #category : #accessing }
BlDropHandler >> dragLeaveEvent: aDropLeaveEvent [
	aDropLeaveEvent currentTarget
		dispatchEvent: (BlItemsLeftEvent new position: aDropLeaveEvent localPosition)
]

{ #category : #accessing }
BlDropHandler >> dropEvent: aDropEvent [
	aDropEvent consumed: true.
	
	aDropEvent currentTarget
		dispatchEvent: (BlItemsLeftEvent new position: aDropEvent localPosition).

	aDropEvent currentTarget space dispatchEvent: (BlSpaceDragDropEvent new
		element: aDropEvent currentTarget;
		delegate: self createDropDelegate;
		position: aDropEvent position)
]

{ #category : #accessing }
BlDropHandler >> eventsToHandle [
	^ { BlDropEvent . BlDragEvent . BlDragEnterEvent . . BlDragLeaveEvent . BlItemsDroppedEvent . BlItemsDraggedEvent . BlItemsLeftEvent . BlItemsEnteredEvent}
]

{ #category : #accessing }
BlDropHandler >> initialize [
	super initialize.

	acceptConditions := OrderedCollection new.
	itemsDroppedAction := [ :aBlItemsDroppedEvent | ].
	itemsDraggedAction := [ :aBlItemsDraggedEvent | ].
	itemsDragLeftAction := [ :aBlItemsDragLeftEvent | ].
	itemsDragEnteredAction := [ :aBlItemsEnteredEvent | ].
]

{ #category : #accessing }
BlDropHandler >> itemsDraggedEvent: anItemsDraggedEvent [
	itemsDraggedAction cull: anItemsDraggedEvent
]

{ #category : #accessing }
BlDropHandler >> itemsDroppedEvent: anItemsDroppedEvent [
	itemsDroppedAction cull: anItemsDroppedEvent
]

{ #category : #accessing }
BlDropHandler >> itemsEnteredEvent: anItemsEnteredEvent [
	itemsDragEnteredAction cull: anItemsEnteredEvent
]

{ #category : #accessing }
BlDropHandler >> itemsLeftEvent: anItemsLeftEvent [
	itemsDragLeftAction cull: anItemsLeftEvent
]

{ #category : #accessing }
BlDropHandler >> whenDragEnteredDo: aBlock [
	itemsDragEnteredAction := aBlock
]

{ #category : #accessing }
BlDropHandler >> whenDragLeftDo: aBlock [
	itemsDragLeftAction := aBlock
]

{ #category : #accessing }
BlDropHandler >> whenDragOverDo: aBlock [
	itemsDraggedAction := aBlock
]

{ #category : #accessing }
BlDropHandler >> whenDroppedDo: aBlock [
	itemsDroppedAction := aBlock
]

{ #category : #accessing }
BlDropHandler >> whenHorizontalDroppedDo: aBlock [
	"Assuming the children of the container layed out similar to a horizontal linear layout.
	Detect the insertion index for the items and evaluate a block with two arguments:
	 - items dropped event
	 - insertion index in cursor corrdinates [0...children count]"

	self whenDroppedDo: [ :anItemsDroppedEvent |
		| container position childBefore insertIndex |

		container := anItemsDroppedEvent currentTarget.
		position := anItemsDroppedEvent position x.

		childBefore := container children accountedByLayout
			detect: [ :eachChild | position < eachChild bounds inParent center x ]
			ifFound: [ :eachChild | eachChild ]
			ifNone: [ nil ].

		insertIndex := childBefore
			ifNil: [ container childrenCount + 1 ]
			ifNotNil: [ container childIndexOf: childBefore ].

		aBlock cull: anItemsDroppedEvent cull: (insertIndex - 1) ]
]

{ #category : #accessing }
BlDropHandler >> whenHorizontalSlideOverDo: aBlock [
	self whenDragOverDo: [ :anItemsDraggedEvent |
		| draggedElement container position insertIndexAt currentIndex elementToSwap |

		self
			assert: anItemsDraggedEvent items size = 1
			description: [ 'Only works with one item' ].

		draggedElement := anItemsDraggedEvent items first sourceElement.
		container := anItemsDraggedEvent currentTarget.
		
		self
			assert: draggedElement parent == container
			description: [ 'Dragged element must be a child of the container' ].

		position := anItemsDraggedEvent dragContainerCenter x.

		elementToSwap := container children accountedByLayout
			detect: [ :eachChild |
				| eachChildBounds |
				
				eachChildBounds := eachChild bounds inParent.
				position between: eachChildBounds left and: eachChildBounds right ]
			ifFound: [ :eachChild | eachChild ]
			ifNone: [ nil ].

		(elementToSwap notNil)
			ifTrue: [
				insertIndexAt := container childIndexOf: elementToSwap.
				currentIndex := container childIndexOf: draggedElement.

				container
					swapChildAt: currentIndex
					with: insertIndexAt ] ]
]
