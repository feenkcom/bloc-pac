"
I collect objects to an {{gtClass:OrderedCollection}}, using {{gtClass:Mutex}} to ensure unique access and data consistency.
I am useful for testing purpose, e.g., checking right values and execution order.

Someone can add object to the collection using either a generic method {{gtMethod:BlTktExamplesCollector>>#add:}} or {{gtMethod:BlTktExamplesCollector>>#increment}} to add numbers.

"
Class {
	#name : #BlTktExamplesCollector,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'collection',
		'mutex'
	],
	#category : #'BlocPac-Tasker-Examples'
}

{ #category : #adding }
BlTktExamplesCollector >> add: anObject [
	mutex critical: [ collection add: anObject ]
]

{ #category : #accessing }
BlTktExamplesCollector >> collection [
	^ collection
]

{ #category : #accessing }
BlTktExamplesCollector >> increment [
	<return: #Integer>
	^ mutex critical: [ 
		| aNumber |
		aNumber := collection size + 1.
		collection add: aNumber.
		aNumber ]
]

{ #category : #initialization }
BlTktExamplesCollector >> initialize [
	super initialize.
	mutex := Mutex new.
	collection := OrderedCollection new.
]
