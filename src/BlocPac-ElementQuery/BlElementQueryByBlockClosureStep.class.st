Class {
	#name : #BlElementQueryByBlockClosureStep,
	#superclass : #BlElementQueryByPropertySelector,
	#instVars : [
		'blockClosure'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #accessing }
BlElementQueryByBlockClosureStep >> blockClosure [
	^ blockClosure
]

{ #category : #accessing }
BlElementQueryByBlockClosureStep >> blockClosure: anObject [
	blockClosure := anObject
]

{ #category : #'api - query' }
BlElementQueryByBlockClosureStep >> matchesElement: anElement [
	^ [ blockClosure value: anElement ]
		on: Error
		do: [ :e | false ]
]

{ #category : #printing }
BlElementQueryByBlockClosureStep >> printOn: aStream [
	super printOn: aStream.
	
	aStream space; print: self blockClosure
]
