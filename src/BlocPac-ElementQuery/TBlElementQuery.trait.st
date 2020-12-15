"
Defines the reusable element query api 
"
Trait {
	#name : #TBlElementQuery,
	#category : #'BlocPac-ElementQuery-Core'
}

{ #category : #'api - query' }
TBlElementQuery >> / aSelector [
	"Selects among direct children based on a given selector such as id or class"

	self queryStep: (aSelector asElementQuerySelector isDeep: false)
]

{ #category : #'api - query' }
TBlElementQuery >> // aSelector [
	"Selects among all children (depth first) based on a given selector such as id or class"

	self queryStep: (aSelector asElementQuerySelector isDeep: true)
]

{ #category : #'api - query' }
TBlElementQuery >> @ aPredicate [
	"Filters the result of the previous selection based on a predicate (such as index)"

	self queryStep: aPredicate asElementQueryPredicate
]

{ #category : #accessing }
TBlElementQuery >> queryStep: aBlElementStep [
	self explicitRequirement
]
