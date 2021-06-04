"
# Lazy element query
Evaluates a query lazily, allowing users to construct it first and then perform a single computation.
For eager query construction take a look at {{gtClass:BlElementEagerQuery}}

"
Class {
	#name : #BlElementLazyQuery,
	#superclass : #BlElementQuery,
	#instVars : [
		'steps'
	],
	#category : #'BlocPac-ElementQuery-Core'
}

{ #category : #converting }
BlElementLazyQuery >> asBlocResolvedElementsFrom: anElement [
	<return: #Collection of: #BlElement>

	^ (self findMany: anElement) result
]

{ #category : #computing }
BlElementLazyQuery >> findMany: anElement [
	| aResult |

	aResult := BlElementQueryResult new.
	aResult prepareForGroup: anElement.

	self findWithResult: aResult.
	
	^ aResult
]

{ #category : #computing }
BlElementLazyQuery >> findOne: anElement [
	| aResult |

	aResult := BlElementQueryResult new.
	aResult prepareForSingle: anElement.

	self findWithResult: aResult.
	
	^ aResult
]

{ #category : #private }
BlElementLazyQuery >> findWithResult: aResult [
	steps do: [ :eachStep |
		| aPreviousResult aNextResult |
		
		aPreviousResult := aResult lastResult.
		aNextResult := aResult lastResult similar.
		
		eachStep findElementsIn: aPreviousResult andAddTo: aNextResult.

		aResult result: aNextResult ]
]

{ #category : #initialization }
BlElementLazyQuery >> initialize [
	super initialize.
	
	steps := OrderedCollection new
]

{ #category : #testing }
BlElementLazyQuery >> isEmpty [
	^ steps isEmpty
]

{ #category : #accessing }
BlElementLazyQuery >> queryStep: aBlElementStep [
	steps add: aBlElementStep
]
