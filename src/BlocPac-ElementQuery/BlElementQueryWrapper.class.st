Class {
	#name : #BlElementQueryWrapper,
	#superclass : #Object,
	#instVars : [
		'targetQuery'
	],
	#category : #'BlocPac-ElementQuery-Core'
}

{ #category : #'instance creation' }
BlElementQueryWrapper class >> forQuery: aQuery [
	^ self new 
		initializeForTargetQuery: aQuery
]

{ #category : #accessing }
BlElementQueryWrapper >> ensureOne: aQueryResult [
	
	self assert: aQueryResult isNotEmpty.
	self assert: aQueryResult all size equals: 1.
	
	^ aQueryResult
]

{ #category : #initialization }
BlElementQueryWrapper >> initializeForTargetQuery: aQuery [ 
	targetQuery := aQuery
]
