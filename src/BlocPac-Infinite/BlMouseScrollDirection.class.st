Class {
	#name : #BlMouseScrollDirection,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'BlocPac-Infinite-Basic'
}

{ #category : #cleanup }
BlMouseScrollDirection class >> cleanUp [
	uniqueInstance := nil
]

{ #category : #'api - factory' }
BlMouseScrollDirection class >> horizontal [
	^ BlMouseScrollHorizontalDirection uniqueInstance
]

{ #category : #accessing }
BlMouseScrollDirection class >> uniqueInstance [
	^ uniqueInstance ifNil: [ self new ]
]

{ #category : #'api - factory' }
BlMouseScrollDirection class >> vertical [
	^ BlMouseScrollVerticalDirection uniqueInstance
]

{ #category : #'mouse handlers' }
BlMouseScrollDirection >> mouseWheelEvent: anEvent [
	"Scroll an infinite element to a direction indicated by the event"
	self subclassResponsibility
]

{ #category : #accessing }
BlMouseScrollDirection >> name [
	^ self className
]

{ #category : #printing }
BlMouseScrollDirection >> printOn: aStream [
	aStream 
		print: self name;
		nextPutAll: ' direction'
]
