"
I am a focus finder.

I am responsible for finding the next focusable element in a given direction from provided focused element

"
Class {
	#name : #BlFocusFinder,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'rootElement',
		'direction',
		'reference',
		'bestCandidateBounds',
		'temporaryBounds',
		'mustIncludeChildren'
	],
	#category : #'BlocPac-FocusFinder-Core'
}

{ #category : #'api - configuration' }
BlFocusFinder >> backward [
	self direction: BlFocusSearchDirectionBackward new
]

{ #category : #accessing }
BlFocusFinder >> bestCandidateBounds [
	^ bestCandidateBounds
]

{ #category : #accessing }
BlFocusFinder >> direction [
	^ direction
]

{ #category : #accessing }
BlFocusFinder >> direction: anObject [
	direction := anObject
]

{ #category : #'api - configuration' }
BlFocusFinder >> down [
	self direction: BlFocusSearchDirectionDown new
]

{ #category : #'api - finder' }
BlFocusFinder >> focusableCandidates [
	| theFocusCandidates |
	
	theFocusCandidates := BlFocusFinderCandidates new.
	
	mustIncludeChildren
		ifTrue: [
			BlFocusabilityBefore new
				focusables: theFocusCandidates along: direction
				of: rootElement ]
		ifFalse: [
			rootElement focusables: theFocusCandidates along: direction ].

	^ theFocusCandidates
]

{ #category : #'api - configuration' }
BlFocusFinder >> forward [
	self direction: BlFocusSearchDirectionForward new
]

{ #category : #'api - configuration' }
BlFocusFinder >> includeChildren [
	mustIncludeChildren := true
]

{ #category : #initialization }
BlFocusFinder >> initialize [
	super initialize.
	
	bestCandidateBounds := BlBounds new.
	temporaryBounds := BlBounds new.

	direction := BlFocusSearchDirectionDown new.
	rootElement := BlElement new.
	reference := BlFocusFinderReferenceNone new.
	mustIncludeChildren := false
]

{ #category : #'api - configuration' }
BlFocusFinder >> left [
	self direction: BlFocusSearchDirectionLeft new
]

{ #category : #'api - finder' }
BlFocusFinder >> nextFocusDo: aBlock [
	"Evaluate aBlock with the next element that should receive focus"
	
	^ self
		nextFocusDo: aBlock
		ifNone: [  ]
]

{ #category : #'api - finder' }
BlFocusFinder >> nextFocusDo: aBlock ifNone: anExceptionBlock [
	"Evaluate aBlock with the next element that should receive focus"
	| aReferenceBounds aReferenceElement theFocusCandidates |

	aReferenceBounds := reference focusBoundsIn: rootElement direction: direction.
	aReferenceElement := reference focusElementIn: rootElement.
	theFocusCandidates := self focusableCandidates.

	^ (direction
		nextFocus: aReferenceElement
		in: theFocusCandidates
		within: rootElement
		from: aReferenceBounds
		finder: self)
			ifNotNil: aBlock
			ifNil: anExceptionBlock
]

{ #category : #accessing }
BlFocusFinder >> reference [
	^ reference
]

{ #category : #accessing }
BlFocusFinder >> reference: anObject [
	reference := anObject
]

{ #category : #'api - configuration' }
BlFocusFinder >> referenceArea: aRectangle [
	self reference: (BlFocusFinderReferenceArea new bounds: aRectangle)
]

{ #category : #'api - configuration' }
BlFocusFinder >> referenceElement: aBlElementOrNil [
	self reference: (aBlElementOrNil
		ifNil: [ BlFocusFinderReferenceNone new ]
		ifNotNil: [ :anElement | BlFocusFinderReferenceElement new element: anElement ])
]

{ #category : #'api - configuration' }
BlFocusFinder >> right [
	self direction: BlFocusSearchDirectionRight new
]

{ #category : #accessing }
BlFocusFinder >> root [
	<return: #BlElement>

	^ rootElement
]

{ #category : #accessing }
BlFocusFinder >> root: aBlElement [
	rootElement := aBlElement
]

{ #category : #accessing }
BlFocusFinder >> temporaryBounds [
	^ temporaryBounds
]

{ #category : #'api - configuration' }
BlFocusFinder >> up [
	self direction: BlFocusSearchDirectionUp new
]
