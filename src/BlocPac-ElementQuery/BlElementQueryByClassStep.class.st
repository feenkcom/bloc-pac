Class {
	#name : #BlElementQueryByClassStep,
	#superclass : #BlElementQueryByPropertySelector,
	#instVars : [
		'elementClass'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #accessing }
BlElementQueryByClassStep >> elementClass [
	^ elementClass
]

{ #category : #accessing }
BlElementQueryByClassStep >> elementClass: anObject [
	elementClass := anObject
]

{ #category : #'api - query' }
BlElementQueryByClassStep >> matchesElement: anElement [
	^ anElement class = self elementClass
]

{ #category : #printing }
BlElementQueryByClassStep >> printOn: aStream [
	super printOn: aStream.
	
	aStream space; nextPutAll: self elementClass name
]
