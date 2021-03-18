Class {
	#name : #BlElementQueryByIdStep,
	#superclass : #BlElementQueryByPropertySelector,
	#instVars : [
		'elementId'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #accessing }
BlElementQueryByIdStep >> elementId [
	^ elementId
]

{ #category : #accessing }
BlElementQueryByIdStep >> elementId: anObject [
	elementId := anObject asBlocElementId
]

{ #category : #'api - query' }
BlElementQueryByIdStep >> matchesElement: anElement [

	"if we query by a non-indexed id and get an element that has indexed id, we try to match the
	prefix of the indexed id with the specified #elementId. This allows us to query lists of elements"
	(self elementId isIndexed not
		and: [ anElement id isIndexed ])
			ifTrue: [ ^ anElement id prefixId = self elementId ].

	^ anElement id = self elementId
]

{ #category : #printing }
BlElementQueryByIdStep >> printOn: aStream [
	super printOn: aStream.
	
	aStream space; print: self elementId
]
