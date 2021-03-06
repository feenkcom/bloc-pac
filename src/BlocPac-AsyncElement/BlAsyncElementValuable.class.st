"
BlAsyncElementValuable is an abstract class that collaborates with {{gtClass:name=BlAsyncElement}} to asynchronously update the state of BlAsyncElements with minimal impact on UI responsiveness.

BlAsyncElementValuable uses the queue priority mechanism in {{gtClass:name=BlTktCommonPriorityQueueWorkerPool}} to update elements that are currently visible on the screen before those that are not.  The priority of the task is based on the element's visiblity and distance from the viewable area, see {{gtMethod:name=BlAsyncElementValuable>>#entryPriority}}.

Subclasses are responsible for deterining the contents and update their element, see {{gtMethod:name=BlAsyncElementValuable>>#updateElement}}.


## Public API and Key Messages
Subclasses of BlAsyncElementValuable typically create their own instance creation methods.

## Internal Representation and Key Implementation Points

### Instance Variables
	element:		<BlAsyncElement> The element being udpated by the receiver


"
Class {
	#name : #BlAsyncElementValuable,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #'BlocPac-AsyncElement'
}

{ #category : #accessing }
BlAsyncElementValuable class >> element: aBlElement [

	^self new element: aBlElement 
]

{ #category : #accessing }
BlAsyncElementValuable >> element [
	^ element
]

{ #category : #accessing }
BlAsyncElementValuable >> element: anObject [
	element := anObject
]

{ #category : #accessing }
BlAsyncElementValuable >> entryPriority [
	"Answer the task priority of the receiver.
	If the element is visible, answer 0 (highest priority), otherwise answer the distance from the center of the display"

	| rootBounds elementBounds |

	element isAttachedToSceneGraph ifFalse: 
		"The element is being pre-loaded, so is lower priority than on-screen elements"
		[ ^5000 ].

	"If a priority has been specified, use that"
	element priority ifNotNil: [ ^element priority ].

	"Determine the of the element and its space (in the parent's coordinate system).
	It may be that the element only takes up part of the space, so this is an approximation.
	ToDo: Be able to set the parent element which should be used to calculate the distance"
	rootBounds := element visibleElement boundsInSpace.
	elementBounds := element boundsInSpace.

	"If the element is visible, load at high priority"
	(rootBounds containsRect: elementBounds) ifTrue: [ ^1 ].
	"Otherwise, priority is proportional to distance from viewable area"
	^rootBounds center distanceTo: elementBounds center
]

{ #category : #acccessing }
BlAsyncElementValuable >> extent [ 
	"Answer the receiver's element extent if open, or nil"

	| extent |

	extent := element extent.
	^(extent x = 0 or: [ extent y = 0 ]) 
		ifTrue: [ nil ]
		ifFalse: [ extent ]
]

{ #category : #private }
BlAsyncElementValuable >> updateElement [
	"Update the receiver's element"

	self subclassResponsibility
]

{ #category : #evaluating }
BlAsyncElementValuable >> value [

	^[ element needsUpdate 
			ifTrue: [ self updateElement ]
			ifFalse: [ nil ] ]
		on: Error
		do: [ :ex | element exception: ex ]
]
