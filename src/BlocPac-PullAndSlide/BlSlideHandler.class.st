Class {
	#name : #BlSlideHandler,
	#superclass : #BlEventListener,
	#instVars : [
		'originalPosition',
		'dragStartPosition',
		'targetElement'
	],
	#category : #'BlocPac-PullAndSlide-Handlers'
}

{ #category : #'dnd handlers' }
BlSlideHandler >> dragEvent: anEvent [
	| aStartPosition aCurrentPosition aDelta aTargetElement |
	anEvent consumed: true.
	
	aTargetElement := targetElement ifNil: anEvent currentTarget.

	aStartPosition := aTargetElement globalPointToLocal: dragStartPosition.
	aCurrentPosition := aTargetElement globalPointToLocal: anEvent position.

	aDelta := (aCurrentPosition - aStartPosition) rounded.

	aTargetElement children accountedByLayout do: [ :aChild |
		| aChildStartPosition |

		aChildStartPosition := aChild userData
			at: #slideHandlerStartPosition
			ifAbsentPut: [ aChild constraints position ].
		
		aChild relocate: aChildStartPosition + aDelta ]
]

{ #category : #'dnd handlers' }
BlSlideHandler >> dragStartEvent: anEvent [
	anEvent consumed: true.

	"drag start position in local"
	dragStartPosition := anEvent position.
	
	(targetElement ifNil: anEvent currentTarget) children accountedByLayout
		do: [ :aChild | aChild userData at: #slideHandlerStartPosition put: aChild constraints position ]
]

{ #category : #accessing }
BlSlideHandler >> targetElement [
	^ targetElement
]

{ #category : #accessing }
BlSlideHandler >> targetElement: anObject [
	targetElement := anObject
]
