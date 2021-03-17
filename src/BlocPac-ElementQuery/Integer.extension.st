Extension { #name : #Integer }

{ #category : #'*BlocPac-ElementQuery' }
Integer >> asElementQueryPredicate [
	^ BlElementQueryByIndexPredicate new elementIndex: self
]
