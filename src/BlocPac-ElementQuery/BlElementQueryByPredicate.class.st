Class {
	#name : #BlElementQueryByPredicate,
	#superclass : #BlElementQueryStep,
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #converting }
BlElementQueryByPredicate >> asElementQueryPredicate [
	^ self
]

{ #category : #printing }
BlElementQueryByPredicate >> printOn: aStream [
	aStream nextPutAll: '@'
]
