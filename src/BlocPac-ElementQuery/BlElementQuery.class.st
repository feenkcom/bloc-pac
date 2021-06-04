"
# Element query
Provides a domain specific language for quering a scene graph of elements in an `XPath` style

There are two types of queries: {{gtClass:BlElementLazyQuery|label=Lazy}} and eager {{gtClass:BlElementEagerQuery|label=Eager}}

"
Class {
	#name : #BlElementQuery,
	#superclass : #Object,
	#traits : 'TBlElementQuery',
	#classTraits : 'TBlElementQuery classTrait',
	#category : #'BlocPac-ElementQuery-Core'
}

{ #category : #private }
BlElementQuery >> findNext: aStep result: aQueryResult [
	| aPreviousResult aNextResult |
		
	aPreviousResult := aQueryResult lastResult.
	aNextResult := aQueryResult lastResult similar step: aStep.
		
	aStep findElementsIn: aPreviousResult andAddTo: aNextResult.

	aQueryResult result: aNextResult
]

{ #category : #accessing }
BlElementQuery >> queryStep: aBlElementStep [
	self subclassResponsibility
]
