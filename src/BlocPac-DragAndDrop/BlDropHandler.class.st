Class {
	#name : #BlDropHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'itemsDroppedAction',
		'acceptConditions'
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
	^ { BlDropEvent . BlItemsDroppedEvent . BlDragEnterEvent . BlDragLeaveEvent}
]

{ #category : #accessing }
BlDropHandler >> initialize [
	super initialize.

	acceptConditions := OrderedCollection new.
	itemsDroppedAction := [ :aBlItemsDroppedEvent | ]
]

{ #category : #accessing }
BlDropHandler >> itemsDroppedEvent: anItemsDroppedEvent [
	itemsDroppedAction cull: anItemsDroppedEvent
]

{ #category : #accessing }
BlDropHandler >> whenDroppedDo: aBlock [
	itemsDroppedAction := aBlock
]
