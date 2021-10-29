Class {
	#name : #BlCommonParentDetector,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'elements',
		'elementsWithoutCommonParent',
		'provisionalCommonParent',
		'commonParent'
	],
	#category : #'BlocPac-CommonParent'
}

{ #category : #'instance creation' }
BlCommonParentDetector class >> forElements: aCollectionOfElements [
	^ self new setElements: aCollectionOfElements
]

{ #category : #'api - adding' }
BlCommonParentDetector >> addElement: anElement [
	| aPreviousCommonParent aNewCommonParent |

	anElement addEventHandler: self.
	
	elements := elements copyWith: anElement.
	elementsWithoutCommonParent add: anElement.
	
	aPreviousCommonParent := commonParent.
	commonParent := nil.
	provisionalCommonParent ifNil: [ provisionalCommonParent := anElement ].
	
	self
		detectCommonParentFor: anElement
		ifFound: [ :aCommonParent | commonParent := aCommonParent ].

	aNewCommonParent := commonParent.

	"there was no common parent and there is still no - do nothing"
	(aPreviousCommonParent isNil and: [ aNewCommonParent isNil ])
		ifTrue: [ ^ self ].

	(aPreviousCommonParent notNil and: [ aNewCommonParent isNil ])
		ifTrue: [ ^ self commonParentLost: aPreviousCommonParent dueToElement: anElement ].

	(aPreviousCommonParent isNil and: [ aNewCommonParent notNil ])
		ifTrue: [ ^ self commonParentFound: aNewCommonParent ].

	aPreviousCommonParent == aNewCommonParent
		ifTrue: [ ^ self ].

	self commonParentLost: aPreviousCommonParent dueToElement: anElement.
	self commonParentFound: aNewCommonParent
]

{ #category : #'api - accessing' }
BlCommonParentDetector >> commonParent [

	^ commonParent
]

{ #category : #private }
BlCommonParentDetector >> commonParentFound: anElement [
	commonParent := anElement.

	elements do: [ :eachElement |
		| aParentChain |
		
		aParentChain := BlParentChain of: eachElement upToExclusive: commonParent.
		
		eachElement dispatchEvent: (BlCommonParentFoundEvent new commonParent: anElement; parentChain: aParentChain) ]
]

{ #category : #private }
BlCommonParentDetector >> commonParentLost: aPreviousCommonParent dueToElement: anElement [
	commonParent := nil.

	elements do: [ :eachElement | 
		eachElement == anElement ifFalse: [ 
			self
				notifyCommonParentLost: aPreviousCommonParent
				of: eachElement ] ]
]

{ #category : #private }
BlCommonParentDetector >> commonParentLost: aPreviousCommonParent dueToRemoval: anElement from: aParentElement [
	commonParent := nil.

	elements do: [ :eachElement |
		| aParentChain |

		aParentChain := BlParentChain of: eachElement upToInclusive: aPreviousCommonParent.
		
		(aParentChain first = aPreviousCommonParent)
			ifFalse: [
				aParentChain first = anElement
					ifFalse: [ aParentChain addFirst: anElement ].
				aParentChain first = aParentElement
					ifFalse: [
						(BlParentChain of: aParentElement upToInclusive: aPreviousCommonParent)
							reverseDo: [ :eachParent | aParentChain addFirst: eachParent ] ]. ].
					
		aParentChain removeFirst.

		eachElement dispatchEvent: (BlCommonParentLostEvent new commonParent: anElement; parentChain: aParentChain) ]
]

{ #category : #private }
BlCommonParentDetector >> detectCommonParentFor: aTargetElement [
	self
		detectCommonParentFor: aTargetElement
		ifFound: [ :aCommonParent | self commonParentFound: aCommonParent ]
]

{ #category : #private }
BlCommonParentDetector >> detectCommonParentFor: aTargetElement ifFound: aFoundBlock [	

	(provisionalCommonParent isNil and: [ aTargetElement hasParent ])
		ifTrue: [ provisionalCommonParent := aTargetElement parent ].

	"still could not detect a provisional common parent, nothing to do here"
	provisionalCommonParent
		ifNil: [ ^ self ].

	elementsWithoutCommonParent ifEmpty: [
		^ aFoundBlock value: provisionalCommonParent ].

	"a common parent for a target element was already found, do nothing"
	(elementsWithoutCommonParent includes: aTargetElement)
		ifFalse: [ ^ self ].

	provisionalCommonParent withAllParentsDo: [ 
		:aNewProvisionalCommonParent | 
		aTargetElement allParentsDo: [ :eachParent | 
			eachParent == aNewProvisionalCommonParent ifTrue: [ 
				provisionalCommonParent := aNewProvisionalCommonParent.
				elementsWithoutCommonParent remove: aTargetElement ifAbsent: [ ].

				elementsWithoutCommonParent ifEmpty: [ 
					aFoundBlock value: provisionalCommonParent ].

				^ self ] ] ]
]

{ #category : #'element handlers' }
BlCommonParentDetector >> elementAddedToSuperParentEvent: anEvent [
	| aParentElement aTargetElement |

	aTargetElement := anEvent currentTarget.
	aParentElement := anEvent parent.

	self assert: [ elements includes: aTargetElement ] description: [
		self class name , ' was added to ' , aTargetElement asString
		, ' which is not registered as part of the `elements`' ].

	self
		detectCommonParentFor: aTargetElement
		ifFound: [ :aCommonParent | ^ self commonParentFound: aCommonParent ].
		
	elementsWithoutCommonParent copy do: [ :eachElement |
		self
			detectCommonParentFor: eachElement
			ifFound: [ :aCommonParent | ^ self commonParentFound: aCommonParent ] ]
]

{ #category : #'element handlers' }
BlCommonParentDetector >> elementRemovedFromSuperParentEvent: anEvent [
	| aParentElement aTargetElement aPreviousCommonParent aNewCommonParent |

	aTargetElement := anEvent currentTarget.
	aParentElement := anEvent element.

	self assert: [ elements includes: aTargetElement ] description: [ 
		self class name , ' was added to ' , aTargetElement asString
		, ' which is not registered as part of the `elements`' ].
	
	"a common parent for a target element is not yet found, do nothing"
	(elementsWithoutCommonParent includes: aTargetElement)
		ifTrue: [ ^ self ].
	
	provisionalCommonParent == aParentElement
		ifTrue: [ ^ self ].
	(provisionalCommonParent hasParent: aParentElement)
		ifTrue: [ ^ self ].
	
	self resetProvisionalCommonParent.

	aPreviousCommonParent := commonParent.
	elements do: [ :eachElement |
		self
			detectCommonParentFor: eachElement
			ifFound: [ :aCommonParent | aNewCommonParent := aCommonParent ] ].

	"there was no common parent and there is still no - do nothing"
	(aPreviousCommonParent isNil and: [ aNewCommonParent isNil ])
		ifTrue: [ ^ self ].

	(aPreviousCommonParent notNil and: [ aNewCommonParent isNil ])
		ifTrue: [ ^ self commonParentLost: aPreviousCommonParent dueToRemoval: anEvent element from: anEvent parent ].
		
	(aPreviousCommonParent isNil and: [ aNewCommonParent notNil ])
		ifTrue: [ ^ self commonParentFound: aNewCommonParent ].

	aPreviousCommonParent == aNewCommonParent
		ifTrue: [ ^ self ].

	self commonParentLost: aPreviousCommonParent dueToRemoval: anEvent element from: anEvent parent.
	self commonParentFound: aNewCommonParent.
]

{ #category : #'api - accessing' }
BlCommonParentDetector >> elements [
	^ elements
]

{ #category : #'api - accessing' }
BlCommonParentDetector >> elementsWithoutCommonParent [
	^ elementsWithoutCommonParent
]

{ #category : #'api - accessing' }
BlCommonParentDetector >> eventsToHandle [
	^ { BlElementAddedToSuperParentEvent . BlElementRemovedFromSuperParentEvent }
]

{ #category : #initialization }
BlCommonParentDetector >> initialize [
	super initialize.
	
	elements := #().
	elementsWithoutCommonParent := Set new.
	provisionalCommonParent := nil.
	commonParent := nil
]

{ #category : #private }
BlCommonParentDetector >> notifyCommonParentLost: aPreviousCommonParent of: anElement [
	| aParentChain |

	aParentChain := BlParentChain
		of: anElement
		upToExclusive: aPreviousCommonParent.

	anElement dispatchEvent: (BlCommonParentLostEvent new
		commonParent: aPreviousCommonParent;
		parentChain: aParentChain)
]

{ #category : #'api - accessing' }
BlCommonParentDetector >> provisionalCommonParent [

	^ provisionalCommonParent
]

{ #category : #'api - adding' }
BlCommonParentDetector >> removeElement: anElement [
	| aPreviousCommonParent aNewCommonParent |

	commonParent ifNotNil: [ :aCommonParent |
		self
			notifyCommonParentLost: aCommonParent
			of: anElement ].

	anElement removeEventHandler: self.
	
	elements := elements copyWithout: anElement.
	elementsWithoutCommonParent remove: anElement ifAbsent: [ ].
	
	"the last element was removed"
	elements
		ifEmpty: [
			elementsWithoutCommonParent := Set new.
			provisionalCommonParent := nil.
			commonParent := nil.
			^ self ].

	"the last element without common parent was removed - we can directly resolve the common parent"
	(commonParent isNil and: [ provisionalCommonParent notNil and: [ elementsWithoutCommonParent isEmpty ] ])
		ifTrue: [ ^ self commonParentFound: provisionalCommonParent ].
	
	aPreviousCommonParent := commonParent.
	self resetProvisionalCommonParent.
	commonParent := nil.
	
	elements do: [ :eachElement |
		self
			detectCommonParentFor: eachElement
			ifFound: [ :aCommonParent | commonParent := aNewCommonParent := aCommonParent ] ].
	
	"there was no common parent and there is still no - do nothing"
	(aPreviousCommonParent isNil and: [ aNewCommonParent isNil ])
		ifTrue: [ ^ self ].

	(aPreviousCommonParent notNil and: [ aNewCommonParent isNil ])
		ifTrue: [ ^ self commonParentLost: aPreviousCommonParent dueToElement: anElement ].
		
	(aPreviousCommonParent isNil and: [ aNewCommonParent notNil ])
		ifTrue: [ ^ self commonParentFound: aNewCommonParent ].

	aPreviousCommonParent == aNewCommonParent
		ifTrue: [ ^ self ].

	self commonParentLost: aPreviousCommonParent dueToElement: anElement.
	self commonParentFound: aNewCommonParent.
	
]

{ #category : #private }
BlCommonParentDetector >> resetProvisionalCommonParent [
	provisionalCommonParent := elements
		detect: [ :eachElement | eachElement hasParent ]
		ifFound: [ :eachElement | eachElement parent ]
		ifNone: [ nil ].
	elementsWithoutCommonParent := elements asSet reject: [ :eachElement |
		eachElement hasParent and: [
			eachElement parent == provisionalCommonParent ] ].
]

{ #category : #'api - adding' }
BlCommonParentDetector >> setElements: aCollectionOfElements [
	self
		assert: [ aCollectionOfElements notEmpty ]
		description: [ 'There must be at least one element' ].

	elements := aCollectionOfElements asArray.
	self resetProvisionalCommonParent.
	commonParent := nil.

	aCollectionOfElements do: [ :eachElement | eachElement addEventHandler: self ].
	
	elements do: [ :eachElement | self detectCommonParentFor: eachElement ]
]
