"
Drag delegate provides drag items when a visual element lifts.
Drag gesture fails if there are no drag items

"
Class {
	#name : #BlDragDelegate,
	#superclass : #Object,
	#instVars : [
		'items',
		'dragArea',
		'offset'
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

	aDraggedContainer relocate: aPoint - offset
]

{ #category : #accessing }
BlDragDelegate >> dragArea [
	^ dragArea
]

{ #category : #accessing }
BlDragDelegate >> dragArea: anObject [
	dragArea := anObject
]

{ #category : #accessing }
BlDragDelegate >> hasDragArea [
	^ dragArea notNil
]

{ #category : #initialization }
BlDragDelegate >> initialize [
	super initialize.

	items := { }
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

	aContainer addChildren: (self items collect: [ :aDragItem | aDragItem previewElement ]).

	self items do: [ :each |
		each sourceElement states
			addState: BlElementDraggingState uniqueInstance ].

	^ aContainer
]

{ #category : #accessing }
BlDragDelegate >> offset [
	^ offset
]

{ #category : #accessing }
BlDragDelegate >> offset: anObject [
	offset := anObject
]
