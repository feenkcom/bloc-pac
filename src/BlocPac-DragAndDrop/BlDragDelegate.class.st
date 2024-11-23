"
#Drag delegate

*Delegate - A person who attends a meeting, conference, forum, etc., esp. one who is elected or appointed to represent a particular association or other body.*

A drag delegate is appointed by {{gtClass:BlDragHandler}} to handle all drag-related actions such as:
 - what happens when an item is lifted {{gtMethod:BlDragDelegate>>#liftAt:}}, 
 - how dragging of an item from one position to another is handled {{gtMethod:BlDragDelegate>>#drag:to:}},
 - what happens when a drag action is cancelled {{gtMethod:BlDragDelegate>>#cancel:at:in:}}

 A drag delegate contains a collection of {{gtClass:BlDragItem}} that are being dragged.
"
Class {
	#name : #BlDragDelegate,
	#superclass : #Object,
	#instVars : [
		'items',
		'dragArea',
		'offset',
		'movementStrategy',
		'canBeCopied'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #'drag and drop' }
BlDragDelegate >> cancel: aDraggedContainer at: aPoint in: aParentElement [
	"Cancel drag and animate previews"	
	| aCancelAnimation |

	self items ifEmpty: [ ^ self ].

	self items do: [ :eachItem |
		| aPreviewElement |
		aPreviewElement := eachItem previewElement.
		aPreviewElement removeFromParent.
		aPreviewElement relocate: aPoint.
		aParentElement addChild: aPreviewElement ].

	aCancelAnimation := BlParallelAnimation with: (self items collect: [ :aDragItem |
		| aPreviewBounds aSourceBounds aPreviewElement |
		aPreviewElement := aDragItem previewElement.

		aPreviewBounds := aPreviewElement bounds inSpace.
		aSourceBounds := aDragItem sourceElement bounds inSpace.

		BlNumberTransition new
			from: aPoint;
			to: (aSourceBounds center - (aPreviewBounds extent / 2.0));
			easing: (BlDecelerateInterpolator factor: 2);
			duration: 350 milliSeconds;
			onStepDo: [ :aPosition | aPreviewElement relocate: aPosition ];
			onFinishedDo: [ aPreviewElement removeFromParent ] ]).

	aParentElement addAnimation: aCancelAnimation.

	self items do: [ :each |
		each sourceElement states
			removeState: BlElementDraggingState uniqueInstance ]
]

{ #category : #'drag and drop' }
BlDragDelegate >> drag: aDraggedContainer to: aPoint [
	"Drag a container with all previews to a given point in the parent coordinate of the container"

	(BlDragToSignal new
		container: aDraggedContainer;
		position: aPoint;
		offset: offset) emit.

	movementStrategy
		drag: aDraggedContainer
		to: aPoint
		withOffset: offset
]

{ #category : #accessing }
BlDragDelegate >> dragArea [
	<return: #BlElement>

	^ dragArea
]

{ #category : #accessing }
BlDragDelegate >> dragArea: anElement [
	dragArea := anElement
]

{ #category : #accessing }
BlDragDelegate >> enableCopy [
	"When enabled, pressing option on MacOS, alt on Linux or ctrl on Windows will mark dragged items as to be copied rather than moved. This also changes a cursor icon to a platform specific Copy cursor."

	canBeCopied := true
]

{ #category : #accessing }
BlDragDelegate >> hasDragArea [
	^ dragArea notNil
]

{ #category : #initialization }
BlDragDelegate >> initialize [
	super initialize.

	items := { }.
	movementStrategy := BlDragFreeMovementStrategy new.
	canBeCopied := false
]

{ #category : #accessing }
BlDragDelegate >> items [
	"Drag gesture fails if there are no drag items"
	<return: #SequenceableCollection of: #BlDragItem>

	^ items
]

{ #category : #accessing }
BlDragDelegate >> items: aCollectionOfDragItems [
	items := aCollectionOfDragItems
]

{ #category : #'drag and drop' }
BlDragDelegate >> liftAt: aPoint [
	"Lift previews at a given point in space coordinates"
	<return: #BlElement>

	| aContainer |
	aContainer := BlElement new
			layout: BlFrameLayout new;
			beInSingleCompositionLayer;
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c horizontal fitContent.
				c vertical fitContent ].
				

	canBeCopied ifTrue: [
		self setupCopyKeyboardHandler: aContainer ].

	aContainer addChildren: (self items collect: [ :aDragItem | aDragItem previewElement ]).

	self items
		do: [ :each | each sourceElement states addState: BlElementDraggingState uniqueInstance ].
	^ aContainer
]

{ #category : #accessing }
BlDragDelegate >> movementStrategy: aBlDragMovementStrategy [
	movementStrategy := aBlDragMovementStrategy
]

{ #category : #accessing }
BlDragDelegate >> offset [
	^ offset
]

{ #category : #accessing }
BlDragDelegate >> offset: anObject [
	offset := anObject
]

{ #category : #'drag and drop' }
BlDragDelegate >> setupCopyKeyboardHandler: aContainer [
	| aCopyCombination |
	aContainer beFocusable.
	aContainer requestFocus.

	aCopyCombination := OSPlatform current isWindows
		ifTrue: [ BlKeyCombination builder control build ]
		ifFalse: [ BlKeyCombination builder alt build ].

	aContainer
		when: BlKeyDownEvent
			do: [ :anEvent | 
				(anEvent matches: aCopyCombination)
					ifTrue: [ self items do: [ :each | each shouldCopy: true ].
						aContainer space currentCursor: BlCopyCursor new ] ];
		when: BlKeyUpEvent
			do: [ :anEvent | 
				(anEvent matches: aCopyCombination)
					ifTrue: [ self items do: [ :each | each shouldCopy: false ].
						aContainer space currentCursor: nil ] ]
]
