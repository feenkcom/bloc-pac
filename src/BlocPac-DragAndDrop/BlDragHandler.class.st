Class {
	#name : #BlDragHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'liftItemBlock',
		'dragAreaBlock',
		'movementStrategyBlock',
		'canBeCopied'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #'drag and drop' }
BlDragHandler >> allowFreeDrag [
	movementStrategyBlock := [ :anEvent | BlDragHorizontalMovementStrategy new ]
]

{ #category : #'dnd handlers' }
BlDragHandler >> createDragItemFor: aSourceElement [
	<return: #Collection of: #BlDragItem>

	^ liftItemBlock
		ifNil: [
			{ BlDragItem new
				sourceElement: aSourceElement;
				domainObject: nil } ]
		ifNotNil: [ :aBlock | (aBlock cull: aSourceElement) asCollection ]
]

{ #category : #accessing }
BlDragHandler >> dragArea: aBlock [
	dragAreaBlock := aBlock
]

{ #category : #'dnd handlers' }
BlDragHandler >> dragStartEvent: anEvent [
	| aDragDelegate shouldMarkAsCopy |

	anEvent consumed: true.

	aDragDelegate := BlDragDelegate new.
	aDragDelegate items: (self createDragItemFor: anEvent currentTarget).
	aDragDelegate offset: anEvent localPosition.
	
	shouldMarkAsCopy := canBeCopied and: [
		OSPlatform current isWindows
			ifTrue: [ anEvent modifiers isCtrl ]
			ifFalse: [ anEvent modifiers isAlt ] ].
	
	shouldMarkAsCopy ifTrue: [
		aDragDelegate items do: [ :eachItem | eachItem shouldCopy: true ].
		anEvent currentTarget space currentCursor: BlCopyCursor new ].

	canBeCopied ifTrue: [ aDragDelegate enableCopy ].

	dragAreaBlock
		ifNotNil: [ :aBlock |
			aDragDelegate dragArea: (aBlock value: anEvent currentTarget) ].

	movementStrategyBlock
		ifNotNil: [ :aBlock |
			aDragDelegate movementStrategy: (aBlock cull: anEvent currentTarget) ].

	anEvent currentTarget space
		dispatchEvent: (BlSpaceDragLiftEvent new
			dragDelegate: aDragDelegate;
			position: anEvent position)
]

{ #category : #'as yet unclassified' }
BlDragHandler >> enableCopy [
	canBeCopied := true
]

{ #category : #accessing }
BlDragHandler >> eventsToHandle [
	^ { BlDragStartEvent }
]

{ #category : #'as yet unclassified' }
BlDragHandler >> initialize [
	super initialize.
	
	liftItemBlock := nil.
	dragAreaBlock := nil.
	movementStrategyBlock := nil.
	canBeCopied := false
]

{ #category : #accessing }
BlDragHandler >> liftItem: aBlock [
	"Set a block that creates:
	- one BlDragItem instance, or
	- a collection of BlDragItem instances.
	The block has one argument: [ :aSourceElement | BlDragItem new ]"

	liftItemBlock := aBlock
]

{ #category : #'drag and drop' }
BlDragHandler >> restrictDragToHorizontal [
	movementStrategyBlock := [ :anElement | BlDragHorizontalMovementStrategy new ]
]
