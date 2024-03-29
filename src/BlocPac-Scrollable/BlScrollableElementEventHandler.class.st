Class {
	#name : #BlScrollableElementEventHandler,
	#superclass : #BlEventListener,
	#category : #'BlocPac-Scrollable-Core'
}

{ #category : #'mouse handlers' }
BlScrollableElementEventHandler >> gestureScrollEvent: anEvent [
	| aScrollHappened |

	aScrollHappened := anEvent currentTarget scrollBy: (anEvent vector * 400).
	anEvent consumed: aScrollHappened
]

{ #category : #'mouse handlers' }
BlScrollableElementEventHandler >> mouseWheelEvent: anEvent [
	| aScrollHappened |
	
	"I implement touch support, so ignore fake mouse wheel events"
	anEvent isTouch
		ifTrue: [ ^ self ].

	aScrollHappened := anEvent currentTarget scrollBy: (anEvent vector * (20 @ 20 negated)).
	anEvent consumed: aScrollHappened
]
