Class {
	#name : #BlInfiniteMouseScrollDirectionallyLimitedListener,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'direction'
	],
	#category : #'BlocPac-Infinite-Basic'
}

{ #category : #'api - instance creation' }
BlInfiniteMouseScrollDirectionallyLimitedListener class >> horizontal [
	^ self new beHorizontal
]

{ #category : #'api - instance creation' }
BlInfiniteMouseScrollDirectionallyLimitedListener class >> vertical [
	^ self new beVertical
]

{ #category : #'api - direction' }
BlInfiniteMouseScrollDirectionallyLimitedListener >> beHorizontal [
	self direction: BlMouseScrollDirection horizontal
]

{ #category : #'api - direction' }
BlInfiniteMouseScrollDirectionallyLimitedListener >> beVertical [
	self direction: BlMouseScrollDirection vertical
]

{ #category : #initialization }
BlInfiniteMouseScrollDirectionallyLimitedListener >> defaultDirection [
	^ BlMouseScrollDirection vertical
]

{ #category : #'api - direction' }
BlInfiniteMouseScrollDirectionallyLimitedListener >> direction [
	<return: #BlMouseScrollDirection>
	^ direction
]

{ #category : #'api - direction' }
BlInfiniteMouseScrollDirectionallyLimitedListener >> direction: aDirection [
	direction := aDirection
]

{ #category : #'private - accessing' }
BlInfiniteMouseScrollDirectionallyLimitedListener >> eventClass [
	^ BlMouseWheelEvent
]

{ #category : #'api - accessing' }
BlInfiniteMouseScrollDirectionallyLimitedListener >> eventsToHandle [
	^ { self eventClass }
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollDirectionallyLimitedListener >> handleEvent: anEvent [
	anEvent sendTo: self
]

{ #category : #initialization }
BlInfiniteMouseScrollDirectionallyLimitedListener >> initialize [
	super initialize.
	direction := self defaultDirection.
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollDirectionallyLimitedListener >> mouseWheelEvent: anEvent [
	self direction mouseWheelEvent: anEvent
]

{ #category : #printing }
BlInfiniteMouseScrollDirectionallyLimitedListener >> printOn: aStream [
	aStream 
		nextPutAll: 'Event handler of ';
		print: self eventClass;
		nextPutAll: ' in ';
		print: self direction;
		nextPutAll: ' direction'
]

{ #category : #events }
BlInfiniteMouseScrollDirectionallyLimitedListener >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]
