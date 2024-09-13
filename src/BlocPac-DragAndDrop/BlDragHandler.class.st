Class {
	#name : #BlDragHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'liftItemBlock',
		'dragAreaBlock',
		'movementStrategyBlock'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #'drag and drop' }
BlDragHandler >> allowFreeDrag [
	movementStrategyBlock := [ :anEvent | BlDragHorizontalMovementStrategy new ]
]

{ #category : #'dnd handlers' }
BlDragHandler >> createDragItemFor: aSourceElement [
	<return: #BlDragItem>

	^ liftItemBlock
		ifNil: [
			BlDragItem new
				sourceElement: aSourceElement;
				domainObject: nil ]
		ifNotNil: [ :aBlock | aBlock cull: aSourceElement ]
]

{ #category : #accessing }
BlDragHandler >> dragArea: aBlock [
	dragAreaBlock := aBlock
]

{ #category : #'dnd handlers' }
BlDragHandler >> dragStartEvent: anEvent [
	| aDragDelegate |

	anEvent consumed: true.

	aDragDelegate := BlDragDelegate new.
	aDragDelegate items: { self createDragItemFor: anEvent currentTarget }.
	aDragDelegate offset: anEvent localPosition.

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
]

{ #category : #accessing }
BlDragHandler >> liftItem: aBlock [
	liftItemBlock := aBlock
]

{ #category : #'drag and drop' }
BlDragHandler >> restrictDragToHorizontal [
	movementStrategyBlock := [ :anElement | BlDragHorizontalMovementStrategy new ]
]
