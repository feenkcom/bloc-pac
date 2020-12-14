"
!Element query
Provides a domain specific language for quering a scene graph of elements in an ==XPath== style

There are two types of queries: ${class:BlElementLazyQuery|label=Lazy}$ and eager ${class:BlElementEagerQuery|label=Eager}$
"
Class {
	#name : #BlElementQuery,
	#superclass : #Object,
	#category : #'BlocPac-ElementQuery-Core'
}

{ #category : #'api - query' }
BlElementQuery >> / aSelector [
	"Selects among direct children based on a given selector such as id or class"

	self step: (aSelector asElementQuerySelector isDeep: false)
]

{ #category : #'api - query' }
BlElementQuery >> // aSelector [
	"Selects among all children (depth first) based on a given selector such as id or class"

	self step: (aSelector asElementQuerySelector isDeep: true)
]

{ #category : #'api - query' }
BlElementQuery >> @ aPredicate [
	"Filters the result of the previous selection based on a predicate (such as index)"

	self step: aPredicate asElementQueryPredicate
]

{ #category : #private }
BlElementQuery >> findNext: aStep result: aQueryResult [
	| aPreviousResult aNextResult |
		
	aPreviousResult := aQueryResult lastResult.
	aNextResult := aQueryResult lastResult similar step: aStep.
		
	aStep findElementsIn: aPreviousResult andAddTo: aNextResult.

	aQueryResult result: aNextResult
]

{ #category : #accessing }
BlElementQuery >> step: aBlElementStep [
	self subclassResponsibility
]
