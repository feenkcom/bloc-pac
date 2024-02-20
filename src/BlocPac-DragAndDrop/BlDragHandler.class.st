Class {
	#name : #BlDragHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'liftItemBlock'
	],
	#category : #'BlocPac-DragAndDrop'
}

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

{ #category : #'dnd handlers' }
BlDragHandler >> dragStartEvent: anEvent [
	| aDragDelegate |

	anEvent consumed: true.

	aDragDelegate := BlDragDelegate new.
	aDragDelegate items: { self createDragItemFor: anEvent currentTarget }.

	anEvent currentTarget space
		dispatchEvent: (BlSpaceDragLiftEvent new
				delegate: aDragDelegate;
				position: anEvent position)
]

{ #category : #accessing }
BlDragHandler >> eventsToHandle [
	^ { BlDragStartEvent }
]

{ #category : #accessing }
BlDragHandler >> liftItem: aBlock [
	liftItemBlock := aBlock
]
