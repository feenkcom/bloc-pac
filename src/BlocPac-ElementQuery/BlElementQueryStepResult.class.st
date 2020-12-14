Class {
	#name : #BlElementQueryStepResult,
	#superclass : #Object,
	#instVars : [
		'step'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #adding }
BlElementQueryStepResult >> addElement: aFoundElement [
	self subclassResponsibility
]

{ #category : #accessing }
BlElementQueryStepResult >> at: anIndex [
	^ self subclassResponsibility
]

{ #category : #enumerating }
BlElementQueryStepResult >> do: aBlock deep: isDeep [
	self subclassResponsibility
]

{ #category : #initialization }
BlElementQueryStepResult >> initialize [
	super initialize.
	
	step := BlElementQueryInitialStep new
]

{ #category : #testing }
BlElementQueryStepResult >> isEmpty [
	^ self size isZero
]

{ #category : #testing }
BlElementQueryStepResult >> isNotEmpty [
	^ self size > 0
]

{ #category : #accessing }
BlElementQueryStepResult >> result [	
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
BlElementQueryStepResult >> similar [
	^ self class new
]

{ #category : #accessing }
BlElementQueryStepResult >> size [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlElementQueryStepResult >> step [
	^ step
]

{ #category : #accessing }
BlElementQueryStepResult >> step: anObject [
	step := anObject
]

{ #category : #testing }
BlElementQueryStepResult >> wantsMore [
	^ self subclassResponsibility
]

{ #category : #enumerating }
BlElementQueryStepResult >> while: aWhileBlock do: aBlock deep: isDeep [
	self do: [ :eachElement |
		aWhileBlock value
			ifTrue: [ aBlock value: eachElement ]
			ifFalse: [ ^ self ]
	] deep: isDeep
]
