Class {
	#name : #BlElementQueryByBlockClosurePredicate,
	#superclass : #BlElementQueryByPredicate,
	#instVars : [
		'blockClosure'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #accessing }
BlElementQueryByBlockClosurePredicate >> blockClosure [
	^ blockClosure
]

{ #category : #accessing }
BlElementQueryByBlockClosurePredicate >> blockClosure: anObject [
	blockClosure := anObject
]

{ #category : #'api - query' }
BlElementQueryByBlockClosurePredicate >> findElementsIn: aCurrentQueryResult andAddTo: aNewQueryResult [
	aCurrentQueryResult
		forEach: [ :eachElement |
			| aResult |
			aNewQueryResult wantsMore
				ifFalse: [ ^ self ].
			
			aResult := [ self blockClosure cull: eachElement ]
				on: Error
				do: [ :anError | #() ].
				
			aResult isCollection
				ifTrue: [ aResult do: [ :eachResultElement |
					aNewQueryResult wantsMore
						ifFalse: [ ^ self ].	
					aNewQueryResult addElement: eachResultElement ] ].
			
			(aResult isBoolean and: [ aResult ])
				ifTrue: [ aNewQueryResult addElement: eachElement ].
				
			(aResult isKindOf: BlElement)
				ifTrue: [ aNewQueryResult addElement: aResult ] ]
]

{ #category : #printing }
BlElementQueryByBlockClosurePredicate >> printOn: aStream [
	super printOn: aStream.
	
	aStream space; print: self blockClosure
]
