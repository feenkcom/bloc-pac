"
# Query result
A place where a result of the query is stored as well as the intermidiate step results so that users can always backtrack the evaluation and understand when something went wrong

"
Class {
	#name : #BlElementQueryResult,
	#superclass : #Object,
	#instVars : [
		'results'
	],
	#category : #'BlocPac-ElementQuery-Core'
}

{ #category : #testing }
BlElementQueryResult >> hasResult [
	^ self lastResult isNotEmpty
]

{ #category : #initialization }
BlElementQueryResult >> initialize [
	super initialize.

	results := OrderedCollection new
]

{ #category : #accessing }
BlElementQueryResult >> lastResult [
	^ results last
]

{ #category : #initialization }
BlElementQueryResult >> prepareForGroup: anElement [
	results add: (BlElementQueryGroupStepResult new addElement: anElement)
]

{ #category : #initialization }
BlElementQueryResult >> prepareForSingle: anElement [
	results add: (BlElementQuerySingleStepResult new addElement: anElement)
]

{ #category : #accessing }
BlElementQueryResult >> result [
	^ results last result
]

{ #category : #accessing }
BlElementQueryResult >> result: aResult [
	results add: aResult
]
