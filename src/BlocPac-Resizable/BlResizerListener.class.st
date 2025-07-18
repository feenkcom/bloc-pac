"
I am an abstract listener associated with a specific resizer element (e.g., bottom right). My subclasses define the specific behavior.

An element with applied Resizer Listener sends `BlResizerResizedEvent` after the resizing target was resized

"
Class {
	#name : #BlResizerListener,
	#superclass : #BlEventListener,
	#instVars : [
		'dragStartPosition',
		'originalPosition',
		'resizeTarget',
		'originalExtent',
		'minimumExtent',
		'isKeepRatio'
	],
	#category : #'BlocPac-Resizable'
}

{ #category : #accessing }
BlResizerListener >> dispatchEventComputedUsing: anEventComputation toCurrentTargetAnd: anotherTarget [
	self resizeTarget dispatchEvent: anEventComputation value.
	anotherTarget dispatchEvent: anEventComputation value
]

{ #category : #'dnd handlers' }
BlResizerListener >> dragDelta: anEvent [
	"The old computation fails when resizing elements within a BlCanvassableElement.
	OLD:
		dragPosition := anEvent position.
		dragDelta := dragPosition - dragStartPosition."

	| dragPosition startPosition |
	dragPosition := anEvent position.
	startPosition := dragStartPosition.
	^ dragPosition - startPosition
]

{ #category : #'dnd handlers' }
BlResizerListener >> dragEndEvent: anEvent [
	| dragDelta theBounds |
	anEvent consumed: true.
	
	self hasTarget
		ifFalse: [ ^ self ].
		
	dragDelta := self dragDelta: anEvent.

	theBounds := BlBounds origin: originalPosition extent: originalExtent.

	self
		resizeBounds: theBounds
		by: dragDelta.
		
	self 
		dispatchEventComputedUsing: [ BlResizerResizeEndedEvent new
			modifiers: anEvent modifiers;
			originalExtent: originalExtent;
			modifiedExtent: theBounds extent ]
		toCurrentTargetAnd: anEvent currentTarget
]

{ #category : #'dnd handlers' }
BlResizerListener >> dragEvent: anEvent [
	<event: #BlResizerResizedEvent>
	| dragDelta theBounds theOriginalBounds widthChanged heightChanged |

	anEvent consumed: true.
	
	self hasTarget
		ifFalse: [ ^ self ].
	self resizeTarget hasParent 
		ifFalse: [ ^ self ].

	dragDelta := self dragDelta: anEvent.

	theBounds := BlBounds origin: originalPosition extent: originalExtent.
	theOriginalBounds := theBounds copy.

	self
		resizeBounds: theBounds
		by: dragDelta.
	
	widthChanged := theBounds width ~= theOriginalBounds width.
	heightChanged := theBounds height ~= theOriginalBounds height.
	
	self resizeTarget globalBoundsToLocal: theBounds.
	self resizeTarget localBoundsToParent: theBounds.
	self resizeTarget parent localBoundsToChildren: theBounds.

	self resizeTarget relocate: theBounds position.
	
	(widthChanged or: [ heightChanged ])
		ifFalse: [ ^ self ].

	widthChanged
		ifTrue: [ self resizeTarget width: theBounds width ].

	heightChanged
		ifTrue: [ self resizeTarget height: theBounds height ].
	
	self 
		dispatchEventComputedUsing: [ BlResizerResizedEvent new 
			modifiers: anEvent modifiers;
			originalExtent: originalExtent;
			extent: theBounds extent;
			resizeTarget: self resizeTarget ]
		toCurrentTargetAnd: anEvent currentTarget
]

{ #category : #'dnd handlers' }
BlResizerListener >> dragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in parent"
	dragStartPosition := anEvent position.

	self hasTarget
		ifFalse: [ ^ self ].

	"element's original extent"
	originalExtent := self resizeTarget bounds inSpace extent.
	originalPosition := self resizeTarget bounds inSpace position.
	
	self 
		dispatchEventComputedUsing: [ BlResizerResizeStartedEvent new 
			modifiers: anEvent modifiers;
			originalExtent: originalExtent ]
		toCurrentTargetAnd: anEvent currentTarget
]

{ #category : #testing }
BlResizerListener >> hasTarget [
	^ resizeTarget isNotNil
]

{ #category : #initialization }
BlResizerListener >> initialize [
	super initialize.

	minimumExtent := 5 asPoint.
	isKeepRatio := false.
]

{ #category : #testing }
BlResizerListener >> isKeepRatio [
	^ isKeepRatio ifNil: [ false ]
]

{ #category : #accessing }
BlResizerListener >> keepRatio: aBoolean [
	isKeepRatio := aBoolean
]

{ #category : #resizer }
BlResizerListener >> minimumExtent [
	<return: #Point>

	^ minimumExtent
]

{ #category : #resizer }
BlResizerListener >> minimumExtent: aPoint [
	minimumExtent := aPoint
]

{ #category : #'mouse handlers' }
BlResizerListener >> mouseDownEvent: anEvent [
	anEvent consumed: true
]

{ #category : #'mouse handlers' }
BlResizerListener >> mouseEnterEvent: anEvent [
	anEvent currentTarget mouseCursor: self resizerCursor
]

{ #category : #'mouse handlers' }
BlResizerListener >> mouseLeaveEvent: anEvent [
	anEvent currentTarget mouseCursor: nil
]

{ #category : #resizer }
BlResizerListener >> resizeBounds: aBlBounds by: aPoint [
	self subclassResponsibility
]

{ #category : #accessing }
BlResizerListener >> resizeTarget [
	^ resizeTarget
]

{ #category : #accessing }
BlResizerListener >> resizeTarget: anObject [
	resizeTarget := anObject
]

{ #category : #resizer }
BlResizerListener >> resizeTargetBy: aDelta [
	(aDelta isZero not)
		ifTrue: [ ^ self resizeTarget size: aDelta ].

	aDelta x isZero
		ifTrue: [ ^ self resizeTarget width: aDelta x ].
		
	aDelta y isZero
		ifTrue: [ ^ self resizeTarget height: aDelta x isZero ]
]

{ #category : #resizer }
BlResizerListener >> resizerCursor [
	<return: #Form>

	^ self subclassResponsibility
]
