"
I am an event listener that overlay element adds to the reference element in order to relocate and resize itself according to that element

"
Class {
	#name : #BlOverlayListener,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'overlayElement',
		'attachmentsCount'
	],
	#category : #'BlocPac-Overlay'
}

{ #category : #'instance creation' }
BlOverlayListener class >> for: anOverlayElement [
	^ self basicNew
		initialize;
		overlayElement: anOverlayElement
]

{ #category : #'instance creation' }
BlOverlayListener class >> new [
	self error: 'Do not create an instance of ', self name, ' using new. Please use #for: instead'
]

{ #category : #'element handlers' }
BlOverlayListener >> elementExtentChangedEvent: anEvent [
	self resizeTo: anEvent currentTarget
]

{ #category : #'element handlers' }
BlOverlayListener >> elementPositionInSpaceChangedEvent: anEvent [
	self relocateTo: anEvent currentTarget
]

{ #category : #'element handlers' }
BlOverlayListener >> elementTransformationInSpaceChangedEvent: anEvent [
	self relocateTo: anEvent currentTarget.
	self resizeTo: anEvent currentTarget.
]

{ #category : #'api - accessing' }
BlOverlayListener >> eventsToHandle [
	^ {
		BlElementExtentChangedEvent .
		BlElementPositionInSpaceChangedEvent .
		BlElementTransformationInSpaceChangedEvent .
	}
]

{ #category : #geometry }
BlOverlayListener >> extentFor: anElement [
	<return: #Point>

	^ anElement
		firstCommonParent: self overlayElement
		ifFound: [ :aCommonParent |
			((anElement bounds inParent: aCommonParent)
				inChild: self overlayElement) extent ]
		ifNone: [ 0@0 ]
]

{ #category : #initialization }
BlOverlayListener >> initialize [
	super initialize.
	
	attachmentsCount := 0
]

{ #category : #'api - hooks' }
BlOverlayListener >> onInstalledIn: anElement [
	self
		assert: [ attachmentsCount isZero ]
		description: [ 'I must be attached to at most one element' ].
		
	attachmentsCount := attachmentsCount + 1.
	
	self relocateTo: anElement.
	self resizeTo: anElement
]

{ #category : #'api - hooks' }
BlOverlayListener >> onUninstalledIn: anObject [
	
	self
		assert: [ attachmentsCount = 1 ]
		description: [ 'I must be attached to at most one element' ].
	
	attachmentsCount := attachmentsCount - 1
]

{ #category : #accessing }
BlOverlayListener >> overlayElement [
	<return: #BlOverlayElement>

	^ overlayElement
]

{ #category : #accessing }
BlOverlayListener >> overlayElement: anOverlayElement [

	self
		assert: [ anOverlayElement isNotNil ]
		description: [ 'Overlay element must not be nil' ].

	overlayElement := anOverlayElement
]

{ #category : #geometry }
BlOverlayListener >> positionFor: anElement [
	<return: #Point>
	| aNewPosition |
	self
		assert: [ anElement isNotNil ]
		description: [ 'Reference element must not be nil' ].

	aNewPosition := self overlayElement
			globalPointToParent: anElement bounds inSpace position.

	self overlayElement hasParent
		ifTrue: [ aNewPosition := self overlayElement parent localPointToChildren: aNewPosition ].

	^ aNewPosition
]

{ #category : #'api - updating' }
BlOverlayListener >> relocateTo: anElement [
	self overlayElement relocate: (self positionFor: anElement)
]

{ #category : #'api - updating' }
BlOverlayListener >> resizeTo: anElement [
	self overlayElement size: (self extentFor: anElement)
]
