"
# Eager element query
Evaluates a query at the time of its construction, selecting and filtering elements after every step.
For lazy query construction take a look at {{gtClass:BlElementLazyQuery}}

"
Class {
	#name : #BlElementEagerQuery,
	#superclass : #BlElementQuery,
	#instVars : [
		'result'
	],
	#category : #'BlocPac-ElementQuery-Core'
}

{ #category : #accessing }
BlElementEagerQuery >> all [
	"Return an array wth results if they exist or empty collection"

	^ result lastResult all
]

{ #category : #accessing }
BlElementEagerQuery >> anyOne [
	"Return just one element (or nil)"

	^ result lastResult anyOne
]

{ #category : #accessing }
BlElementEagerQuery >> forMany: anElement [
	result := BlElementQueryResult new.
	result prepareForGroup: anElement
]

{ #category : #accessing }
BlElementEagerQuery >> forOne: anElement [
	result := BlElementQueryResult new.
	result prepareForSingle: anElement
]

{ #category : #accessing }
BlElementEagerQuery >> queryStep: aBlElementStep [
	self findNext: aBlElementStep result: result
]

{ #category : #accessing }
BlElementEagerQuery >> result [
	"Return either a resulting collection of elements or just one element (or nil)"

	^ result lastResult result
]
