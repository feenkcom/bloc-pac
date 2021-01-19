"
I am a ${class:BeaconSignal}$.
I collect information about ${class:BlMouseWheelEvent}$ instances.
"
Class {
	#name : #BlMouseWheelEventSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'event',
		'dX',
		'dY'
	],
	#category : #'BlocPac-Infinite-Basic'
}

{ #category : #'api - accessing' }
BlMouseWheelEventSignal >> dX [
	^ dX
]

{ #category : #'api - accessing' }
BlMouseWheelEventSignal >> dX: anObject [
	dX := anObject
]

{ #category : #'api - accessing' }
BlMouseWheelEventSignal >> dY [
	^ dY
]

{ #category : #'api - accessing' }
BlMouseWheelEventSignal >> dY: anObject [
	dY := anObject
]

{ #category : #'api - accessing' }
BlMouseWheelEventSignal >> event [
	^ event
]

{ #category : #'api - accessing' }
BlMouseWheelEventSignal >> event: anObject [
	event := anObject
]

{ #category : #accessing }
BlMouseWheelEventSignal >> gtVectorFor: aView [
	<gtView>
	self event ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Vector';
		object: [ self event ];
		view: #gtVectorFor:
]

{ #category : #printing }
BlMouseWheelEventSignal >> printOneLineContentsOn: aStream [
	self event ifNil: [ ^ self ].
	aStream 
		nextPutAll: 'length = ';
		nextPutAll: (self event vector length printShowingDecimalPlaces: 3).
	self event vector length isZero ifTrue: [ ^ self ].
	aStream 
		nextPutAll: ', degree = ';
		nextPutAll: (self event vector degrees printShowingDecimalPlaces: 1);
		nextPut: $°
]
