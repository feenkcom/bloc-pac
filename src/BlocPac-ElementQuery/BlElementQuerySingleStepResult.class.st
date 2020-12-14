Class {
	#name : #BlElementQuerySingleStepResult,
	#superclass : #BlElementQueryStepResult,
	#instVars : [
		'element'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #adding }
BlElementQuerySingleStepResult >> addElement: aFoundElement [
	element := aFoundElement
]

{ #category : #accessing }
BlElementQuerySingleStepResult >> at: anIndex [
	anIndex = 1
		ifFalse: [ SubscriptOutOfBounds signalFor: anIndex ].
		
	element
		ifNil: [ SubscriptOutOfBounds signalFor: anIndex ].
		
	^ element
]

{ #category : #displaying }
BlElementQuerySingleStepResult >> displayString [
	^ self isEmpty
		ifTrue: [ '0 elements' ]
		ifFalse: [ element displayString ]
]

{ #category : #enumerating }
BlElementQuerySingleStepResult >> do: aBlock deep: isDeep [
	element ifNotNil: [ :anElement |
		isDeep
			ifTrue: [ anElement allChildrenDepthFirstDo: aBlock ]
			ifFalse: [ anElement childrenDo: aBlock ] ]
]

{ #category : #accessing }
BlElementQuerySingleStepResult >> result [	
	^ element
]

{ #category : #accessing }
BlElementQuerySingleStepResult >> size [
	^ element
		ifNil: [ 0 ]
		ifNotNil: [ 1 ]
]

{ #category : #testing }
BlElementQuerySingleStepResult >> wantsMore [
	^ element isNil
]
