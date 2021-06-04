"
I am a port of the old BouncingAtomsMorph demo.

The following will open a demo in a new window:
```
BlBouncingAtomsElement open
```

Alternatively inspect the following:
```
BlBouncingAtomsElement demo 
```

For a demo, open a new Inspector window.
Inspect the children and select a random one.
Set its background color to blue (self background: Color blue).
Query and set its velocity to 0@0 and 20@20, and its size to 10@10.


"
Class {
	#name : #BlBouncingAtomsElement,
	#superclass : #BlElement,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#instVars : [
		'damageReported',
		'task'
	],
	#category : #'BlocPac-Demos-Bouncing atoms'
}

{ #category : #accessing }
BlBouncingAtomsElement class >> demo [
	<script: 'self demo'>
	^ self new
		background: Color lightGreen;
		initializeWith: 300 ofSize: 5 @ 5 within: 400 @ 300
]

{ #category : #'instance creation' }
BlBouncingAtomsElement class >> open [
	<script: 'self open'>

	self
		openInWindow: (self new initializeWith: 1000 ofSize: 5@5 within: 800@600)
		named: 'Bouncing Atoms'
		extent: 800@600
]

{ #category : #initialization }
BlBouncingAtomsElement >> addAtoms: aCollectionOfAtomElements ofSize: anAtomSize within: anSceneExtent [
	"Add a bunch of new atoms."

	aCollectionOfAtomElements do: [ :anAtomElement |
		anAtomElement size: anAtomSize.
		self
			randomizePositionOf: anAtomElement
			in: (0@0 extent: anSceneExtent)
			maxVelocity: 3
			extent: anAtomSize ].

	self addChildren: aCollectionOfAtomElements
]

{ #category : #initialization }
BlBouncingAtomsElement >> drawMeAndChildrenOnSpartaCanvas: aCanvas [
	super drawMeAndChildrenOnSpartaCanvas: aCanvas.
	damageReported := false
]

{ #category : #initialization }
BlBouncingAtomsElement >> go [
	"Start the animation"

	task := BlRepeatedTaskAction new
		delay: 0 milliSeconds;
		action: [ self step ].
	self enqueueTask: task.
	damageReported := false
]

{ #category : #initialization }
BlBouncingAtomsElement >> initialize [
	super initialize.
	self go
]

{ #category : #initialization }
BlBouncingAtomsElement >> initializeWith: aNumberOfAtoms ofSize: anAtomExtent within: aSceneExtent [
	self size: aSceneExtent.
	self
		addAtoms: (aNumberOfAtoms timesCollect: [ self newAtom ])
		ofSize: anAtomExtent
		within: aSceneExtent
]

{ #category : #'change reporting' }
BlBouncingAtomsElement >> invalidRect: aBlBounds from: anElement [
	damageReported
		ifTrue: [ ^ self ].

	super invalidRect: (self invalidationBounds) from: anElement.
		
	damageReported := true
]

{ #category : #'instance creation' }
BlBouncingAtomsElement >> newAtom [
	^ BlAtomElement new
]

{ #category : #accessing }
BlBouncingAtomsElement >> onAddedToSceneGraph [
	"Workaround to restart the animation when it is back in focus."

	super onAddedToSceneGraph.
	self task isRunning
		ifFalse: [ self go ]
]

{ #category : #initialization }
BlBouncingAtomsElement >> randomizePositionOf: anAtomElement in: aRectangle maxVelocity: maxVelocity extent: anAtomExtent [
	"Give this atom a random position and velocity"
	| anExtent |

	anExtent := (aRectangle extent - anAtomExtent) rounded.

	anAtomElement relocate: (anExtent x atRandom) @ (anExtent y atRandom).
	anAtomElement velocity: (maxVelocity - (2 * maxVelocity) atRandom) @ (maxVelocity - (2 * maxVelocity) atRandom)
]

{ #category : #'stepping and presenter' }
BlBouncingAtomsElement >> step [
	"Bounce those atoms!"

	| r |
	r := self measuredBounds topLeft
		corner: self bounds extent - BlAtomElement defaultSize.
	self childrenDo: [ :m | m bounceIn: r ]
]

{ #category : #accessing }
BlBouncingAtomsElement >> task [
^ task
]
