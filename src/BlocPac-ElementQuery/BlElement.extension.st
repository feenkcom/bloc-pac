Extension { #name : #BlElement }

{ #category : #'*BlocPac-ElementQuery' }
BlElement >> asElementQueryPredicate [
	^ BlElementQueryByElementPredicate new element: self
]

{ #category : #'*BlocPac-ElementQuery' }
BlElement >> query [
	^ BlElementEagerQuery new forMany: self
]
