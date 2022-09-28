"
I am an event listener that listens Anchor Moved event send by Anchor

"
Class {
	#name : #BlAnchorEventListener,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'geometryElement'
	],
	#category : #'BlocPac-Geometry-Base'
}

{ #category : #'instance creation' }
BlAnchorEventListener class >> for: aGeometryElement [
	<return: #BlAnchorEventListener>

	^ self new geometryElement: aGeometryElement
]

{ #category : #'element handlers' }
BlAnchorEventListener >> commonParentFoundEvent: anEvent [
	anEvent parentChain
		do: [ :eachElement | 
			(eachElement ~~ anEvent currentTarget
				and: [ eachElement ~~ geometryElement
						and: [ (eachElement eventDispatcher hasHandler: self) not ] ])
				ifTrue: [ eachElement addEventHandler: self ] ]
]

{ #category : #'element handlers' }
BlAnchorEventListener >> commonParentLostEvent: anEvent [
	anEvent parentChain do: [ :eachElement |
		(eachElement ~~ anEvent currentTarget
			and: [ eachElement ~~ geometryElement ])
				ifTrue: [ eachElement removeEventHandler: self ] ]
]

{ #category : #'element handlers' }
BlAnchorEventListener >> elementExtentChangedEvent: anEvent [
	self onAnchorMoved
]

{ #category : #'element handlers' }
BlAnchorEventListener >> elementPositionChangedEvent: anEvent [
	self onAnchorMoved
]

{ #category : #'element handlers' }
BlAnchorEventListener >> elementTransformationChangedEvent: anEvent [
	self onAnchorMoved
]

{ #category : #'api - accessing' }
BlAnchorEventListener >> eventsToHandle [

	^ { 
		  BlElementPositionChangedEvent.
		  BlElementExtentChangedEvent.
		  BlElementTransformationChangedEvent.
		  BlCommonParentFoundEvent.
		  BlCommonParentLostEvent }
]

{ #category : #accessing }
BlAnchorEventListener >> geometryElement [
	<return: #BlElement>

	^ geometryElement
]

{ #category : #accessing }
BlAnchorEventListener >> geometryElement: aBlElement [
	geometryElement := aBlElement
]

{ #category : #anchors }
BlAnchorEventListener >> onAnchorMoved [
	self geometryElement onAnchorMoved
]

{ #category : #installation }
BlAnchorEventListener >> onInstalledIn: anObject [
	self
		assert: [ anObject ~~ geometryElement ]
		description: [ 'Should not be installed on the geometry element' ].

	self onAnchorMoved
]
