Class {
	#name : #BlMouseScrollDirectionExamples,
	#superclass : #Object,
	#category : #'BlocPac-Infinite-Examples'
}

{ #category : #'examples - horizontal directions' }
BlMouseScrollDirectionExamples >> basicHorizontalDirection [
	<gtExample>
	| aDirection |
	aDirection := BlMouseScrollHorizontalDirection new.
	^ aDirection
]

{ #category : #'examples - mouse wheel events' }
BlMouseScrollDirectionExamples >> basicMouseWheelEvent [
	<gtExample>
	| anEvent |
	anEvent := BlMouseWheelEvent new.
	self assert: anEvent isConsumed not.
	^ anEvent
]

{ #category : #'examples - vertical directions' }
BlMouseScrollDirectionExamples >> basicVerticalDirection [
	<gtExample>
	| aDirection |
	aDirection := BlMouseScrollVerticalDirection new.
	^ aDirection
]

{ #category : #'examples - elements' }
BlMouseScrollDirectionExamples >> element [
	<gtExample>
	| anElement |
	anElement := BlInfiniteMouseScrollDirectionDummyElement new.
	
	anElement 
		background: Color veryVeryLightGray;
		border: (BlBorder paint: Color lightGray width: 1);
		margin: (BlInsets all: 10);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
	
	^ anElement
]

{ #category : #'examples - horizontal directions' }
BlMouseScrollDirectionExamples >> horizontalDirection_0degrees [
	<gtExample>
	| aDirection anEvent |
	aDirection := self basicHorizontalDirection.
	anEvent := self mouseWheelEvent_0degrees.
	
	aDirection mouseWheelEvent: anEvent.
	
	self assert: anEvent isConsumed description: 'Event must be consumed'.
	self assert: anEvent currentTarget scrolls size equals: 1.
	self assert: anEvent currentTarget scrolls first x > 0.
	self assert: anEvent currentTarget scrolls first y equals: 0.
	
	^ anEvent
]

{ #category : #'examples - horizontal directions' }
BlMouseScrollDirectionExamples >> horizontalDirection_180degrees [
	<gtExample>
	| aDirection anEvent |
	aDirection := self basicHorizontalDirection.
	anEvent := self mouseWheelEvent_180degrees.
	
	aDirection mouseWheelEvent: anEvent.
	
	self assert: anEvent isConsumed description: 'Event must be consumed'.
	self assert: anEvent currentTarget scrolls size equals: 1.
	self assert: anEvent currentTarget scrolls first x < 0.
	self assert: anEvent currentTarget scrolls first y equals: 0.
	
	^ anEvent
]

{ #category : #'examples - horizontal directions' }
BlMouseScrollDirectionExamples >> horizontalDirection_270degrees [
	<gtExample>
	| aDirection anEvent |
	aDirection := self basicHorizontalDirection.
	anEvent := self mouseWheelEvent_270degrees.
	
	aDirection mouseWheelEvent: anEvent.
	
	self assert: anEvent isConsumed not description: 'Event must not be consumed'.
	self assert: anEvent currentTarget scrolls size equals: 0.
	
	^ anEvent
]

{ #category : #'examples - horizontal directions' }
BlMouseScrollDirectionExamples >> horizontalDirection_346degrees [
	<gtExample>
	| aDirection anEvent |
	aDirection := self basicHorizontalDirection.
	anEvent := self mouseWheelEvent_346degrees.
	
	aDirection mouseWheelEvent: anEvent.
	
	self assert: anEvent isConsumed description: 'Event must be consumed'.
	self assert: anEvent currentTarget scrolls size equals: 1.
	self assert: anEvent currentTarget scrolls first x > 0.
	self assert: anEvent currentTarget scrolls first y equals: 0.
	
	^ anEvent
]

{ #category : #'examples - mouse wheel events' }
BlMouseScrollDirectionExamples >> mouseWheelEventWithVector: aVector [
	<gtExample>
	| anEvent anElement |
	anEvent := self basicMouseWheelEvent.

	anEvent vector: aVector.
	anElement := self element.
	anEvent target: anElement.
	anEvent currentTarget: anElement.
	
	self assert: anEvent vector equals: aVector.
	^ anEvent
]

{ #category : #'examples - mouse wheel events' }
BlMouseScrollDirectionExamples >> mouseWheelEvent_0degrees [
	<gtExample>
	^ self mouseWheelEventWithVector: (BlVector x: 10 y: 0).
]

{ #category : #'examples - mouse wheel events' }
BlMouseScrollDirectionExamples >> mouseWheelEvent_180degrees [
	<gtExample>
	^ self mouseWheelEventWithVector: (BlVector x: -10 y: 0).
]

{ #category : #'examples - mouse wheel events' }
BlMouseScrollDirectionExamples >> mouseWheelEvent_270degrees [
	<gtExample>
	^ self mouseWheelEventWithVector: (BlVector x: 0 y: -10).
]

{ #category : #'examples - mouse wheel events' }
BlMouseScrollDirectionExamples >> mouseWheelEvent_346degrees [
	<gtExample>
	^ self mouseWheelEventWithVector: (BlVector x: 4 y: -1).
]

{ #category : #'examples - mouse wheel events' }
BlMouseScrollDirectionExamples >> mouseWheelEvent_45degrees [
	<gtExample>
	^ self mouseWheelEventWithVector: (BlVector x: 10 y: 10).
]

{ #category : #'examples - vertical directions' }
BlMouseScrollDirectionExamples >> verticalDirection_0degrees [
	<gtExample>
	| aDirection anEvent |
	aDirection := self basicVerticalDirection.
	anEvent := self mouseWheelEvent_0degrees.
	
	aDirection mouseWheelEvent: anEvent.
	
	self assert: anEvent isConsumed not description: 'Event must not be consumed'.
	self assert: anEvent currentTarget scrolls size equals: 0.
	
	^ anEvent
]

{ #category : #'examples - vertical directions' }
BlMouseScrollDirectionExamples >> verticalDirection_180degrees [
	<gtExample>
	| aDirection anEvent |
	aDirection := self basicVerticalDirection.
	anEvent := self mouseWheelEvent_180degrees.
	
	aDirection mouseWheelEvent: anEvent.
	
	self assert: anEvent isConsumed not description: 'Event must not be consumed'.
	self assert: anEvent currentTarget scrolls size equals: 0.
	
	^ anEvent
]

{ #category : #'examples - vertical directions' }
BlMouseScrollDirectionExamples >> verticalDirection_270degrees [
	<gtExample>
	| aDirection anEvent |
	aDirection := self basicVerticalDirection.
	anEvent := self mouseWheelEvent_270degrees.
	
	aDirection mouseWheelEvent: anEvent.
	
	self assert: anEvent isConsumed description: 'Event must be consumed'.
	self assert: anEvent currentTarget scrolls size equals: 1.
	
	^ anEvent
]

{ #category : #'examples - vertical directions' }
BlMouseScrollDirectionExamples >> verticalDirection_346degrees [
	<gtExample>
	| aDirection anEvent |
	aDirection := self basicVerticalDirection.
	anEvent := self mouseWheelEvent_346degrees.
	
	aDirection mouseWheelEvent: anEvent.
	
	self assert: anEvent isConsumed not description: 'Event must not be consumed'.
	self assert: anEvent currentTarget scrolls size equals: 0.
	
	^ anEvent
]
