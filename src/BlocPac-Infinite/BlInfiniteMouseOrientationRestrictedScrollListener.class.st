"
I am a ${class:BlBasicEventHandler}$.
I dispatch mouse scroll events to element layouts, see ${method:BlInfiniteMouseScrollOrientationLimitedListener>>#mouseWheelEvent:}$.
By dispaching the scroll event to ${class:BlLayout}$ instances, horizontal infinite elements (lists) can ignore vertical scrolls, and vertical infinite elements can ignore horizontal scrolls.

In case of ${method:BlInfiniteLinearLayout>>#mouseWheelEvent:}$, the scroll happens in ${method:BlInfiniteLayoutOrientation>>#mouseWheelEvent:}$. 

Other layouts ignore the dispatch by defalt, see ${method:BlLayout>>#mouseWheelEvent:}$.

"
Class {
	#name : #BlInfiniteMouseOrientationRestrictedScrollListener,
	#superclass : #BlBasicEventHandler,
	#category : #'BlocPac-Infinite-Basic'
}

{ #category : #'private - accessing' }
BlInfiniteMouseOrientationRestrictedScrollListener >> eventClass [
	^ BlMouseWheelEvent
]

{ #category : #'api - accessing' }
BlInfiniteMouseOrientationRestrictedScrollListener >> eventsToHandle [
	^ { self eventClass }
]

{ #category : #'mouse handlers' }
BlInfiniteMouseOrientationRestrictedScrollListener >> handleEvent: anEvent [
	anEvent sendTo: self
]

{ #category : #'mouse handlers' }
BlInfiniteMouseOrientationRestrictedScrollListener >> mouseWheelEvent: anEvent [
	anEvent currentTarget layout mouseWheelEvent: anEvent.
]

{ #category : #printing }
BlInfiniteMouseOrientationRestrictedScrollListener >> printOn: aStream [
	aStream 
		nextPutAll: 'Event handler of ';
		print: self eventClass;
		nextPutAll: ' in ';
		print: self direction;
		nextPutAll: ' direction'
]

{ #category : #events }
BlInfiniteMouseOrientationRestrictedScrollListener >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
