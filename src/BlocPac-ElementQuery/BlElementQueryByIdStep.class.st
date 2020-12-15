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
	^ anElement id = self elementId
]

{ #category : #printing }
BlElementQueryByIdStep >> printOn: aStream [
	super printOn: aStream.
	
	aStream space; print: self elementId
]
