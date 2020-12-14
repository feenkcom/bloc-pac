Class {
	#name : #BlElementQueryInitialStep,
	#superclass : #BlElementQueryStep,
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #printing }
BlElementQueryInitialStep >> printOn: aStream [
	aStream nextPutAll: 'initial'
]
