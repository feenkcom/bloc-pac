Class {
	#name : #BlElementQueryByIndexPredicate,
	#superclass : #BlElementQueryByPredicate,
	#instVars : [
		'elementIndex'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #accessing }
BlElementQueryByIndexPredicate >> elementIndex [
	^ elementIndex
]

{ #category : #accessing }
BlElementQueryByIndexPredicate >> elementIndex: anObject [
	elementIndex := anObject
]

{ #category : #'api - query' }
BlElementQueryByIndexPredicate >> findElementsIn: aCurrentQueryResult andAddTo: aNewQueryResult [
	aNewQueryResult wantsMore
		ifFalse: [ ^ self ].
		
	self elementIndex > aCurrentQueryResult size
		ifTrue: [ ^ self ].
		
	self elementIndex < 1
		ifTrue: [ ^ self ].
		
	aNewQueryResult addElement: (aCurrentQueryResult at: self elementIndex)
]

{ #category : #initialization }
BlElementQueryByIndexPredicate >> initialize [
	super initialize.
	
	elementIndex := 0
]

{ #category : #printing }
BlElementQueryByIndexPredicate >> printOn: aStream [
	super printOn: aStream.
	
	aStream space; print: self elementIndex
]
