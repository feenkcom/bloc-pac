"
I add an ability to drag (pull) any arbitrary element within its direct parent by requesting position change.
Note, that some layout do not allow elements to have custom positions which means I have no effect.

Example:

```
| element |

element := BlElement new.
element background: Color red.
element size: 75@75.
element addEventHandler: BlPullHandler new.	
```

"
Class {
	#name : #BlPullHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'dragStartGlobalPosition',
		'originalPosition',
		'allowedOutOfBounds',
		'direction',
		'targetElement'
	],
	#classVars : [
		'Any',
		'Horizontal',
		'Vertical'
	],
	#category : #'BlocPac-PullAndSlide-Handlers'
}

{ #category : #'class initialization' }
BlPullHandler class >> initialize [	
	Any := #any.
	Vertical := #vertical.
	Horizontal := #horizontal
]

{ #category : #'api - pull handler' }
BlPullHandler >> allowOutOfBounds [
	"Allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := true
]

{ #category : #'api - pull handler' }
BlPullHandler >> beFree [
	direction := Any
]

{ #category : #'api - pull handler' }
BlPullHandler >> beHorizontal [
	direction := Horizontal
]

{ #category : #'api - pull handler' }
BlPullHandler >> beVertical [
	direction := Vertical
]

{ #category : #'private - pulling' }
BlPullHandler >> computePullDelta: aDragDelta [
	<return: #Number>
	
	direction = Any
		ifTrue: [ ^ aDragDelta ].
		
	direction = Vertical
		ifTrue: [ ^ 0 @ aDragDelta y ].
		
	direction = Horizontal
		ifTrue: [ ^ aDragDelta x @ 0 ].
		
	^ direction
]

{ #category : #'api - pull handler' }
BlPullHandler >> disallowOutOfBounds [
	"Do not allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := false
]

{ #category : #'event handling' }
BlPullHandler >> dragEndEvent: anEvent [
	"anEvent consumed: true."
	
	(self targetElementFor: anEvent) dispatchEvent: BlPullEndEvent new
]

{ #category : #'event handling' }
BlPullHandler >> dragEvent: anEvent [
	| aTargetElement aStartPosition aCurrentPosition aPreviousPosition dragDelta aNewPosition |
	
	dragStartGlobalPosition ifNil: [ dragStartGlobalPosition := anEvent position ].
	
	aTargetElement := self targetElementFor: anEvent.
	
	aCurrentPosition := aTargetElement globalPointToParentChildren: anEvent position.
		aStartPosition := aTargetElement globalPointToParentChildren: dragStartGlobalPosition.

	dragDelta := aCurrentPosition - aStartPosition.
	
	dragDelta := (self computePullDelta: dragDelta) rounded.
	
	aNewPosition := ((originalPosition ifNil: [ originalPosition := aTargetElement constraints position ]) + dragDelta).
	aPreviousPosition := aTargetElement constraints position.

	allowedOutOfBounds ifFalse: [
		| aMaxPosition |

		aMaxPosition := (aTargetElement hasParent
			ifTrue: [ aTargetElement parent extent - aTargetElement extent ]
			ifFalse: [ 0@0 ]).
		aNewPosition := aNewPosition min: aMaxPosition max: 0@0 ].

	aTargetElement relocate: aNewPosition.
	anEvent consumed: true.
	
	self
		onPulled: aTargetElement
		from: aPreviousPosition
		to: aNewPosition
		by: dragDelta
		starting: originalPosition
]

{ #category : #'event handling' }
BlPullHandler >> dragStartEvent: anEvent [
	| aTargetElement |
	anEvent consumed: true.

	aTargetElement := self targetElementFor: anEvent.

	aTargetElement dispatchEvent: BlPullStartEvent new.

	"drag start position in space coordinates"
	dragStartGlobalPosition := anEvent position.

	"element position in parent"
	originalPosition := aTargetElement constraints position
]

{ #category : #'api - accessing' }
BlPullHandler >> eventsToHandle [
	^ { BlDragStartEvent . BlDragEvent . BlDragEndEvent }
]

{ #category : #initialization }
BlPullHandler >> initialize [
	super initialize.
	
	allowedOutOfBounds := true.
	direction := Any
]

{ #category : #'event handling' }
BlPullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition [
	aPulledElement dispatchEvent: (BlPullEvent new
		initialPosition: anOriginalPosition;
		oldPosition: aPreviousPosition;
		newPosition: aNewPosition;
		delta: aDragDelta)
]

{ #category : #'api - pull handler' }
BlPullHandler >> targetElement: anElement [
	targetElement := anElement
]

{ #category : #'private - pulling' }
BlPullHandler >> targetElementFor: anEvent [
	^ targetElement ifNil: [ anEvent currentTarget ]
]
