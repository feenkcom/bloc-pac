Extension { #name : #BlockClosure }

{ #category : #'*BlocPac-ElementQuery' }
BlockClosure >> asElementQueryPredicate [
	^ BlElementQueryByElementPredicate new element: self
]
