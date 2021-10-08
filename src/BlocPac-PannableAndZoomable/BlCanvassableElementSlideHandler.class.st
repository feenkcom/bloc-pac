Class {
	#name : #BlCanvassableElementSlideHandler,
	#superclass : #BlEventListener,
	#instVars : [
		'originalPosition',
		'dragStartPosition'
	],
	#category : #'BlocPac-PannableAndZoomable-Utiltities'
}

{ #category : #'dnd handlers' }
BlCanvassableElementSlideHandler >> dragEvent: anEvent [
	| aStartPosition aCurrentPosition aDelta aTargetElement anInitialTranslation |
	anEvent consumed: true.

	aTargetElement := anEvent currentTarget.

	aStartPosition := aTargetElement globalPointToChildren: dragStartPosition.
	aCurrentPosition := aTargetElement globalPointToChildren: anEvent position.

	aDelta := aCurrentPosition - aStartPosition.
	
	anInitialTranslation := anEvent currentTarget userData
		at: #slideHandlerStartPosition
		ifAbsentPut: [ anEvent currentTarget childrenTranslationFactor ].

	aTargetElement childrenTranslationFactor: anInitialTranslation + aDelta
]

{ #category : #'dnd handlers' }
BlCanvassableElementSlideHandler >> dragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in space"
	dragStartPosition := anEvent position.
	
	anEvent currentTarget userData
		at: #slideHandlerStartPosition
		put: anEvent currentTarget childrenTranslationFactor
]
