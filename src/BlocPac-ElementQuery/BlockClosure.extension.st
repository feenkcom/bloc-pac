Extension { #name : #BlockClosure }

{ #category : #'*BlocPac-ElementQuery' }
BlockClosure >> asElementQueryPredicate [
	^ BlElementQueryByBlockClosurePredicate new blockClosure: self
]

{ #category : #'*BlocPac-ElementQuery' }
BlockClosure >> asElementQuerySelector [
	^ BlElementQueryByBlockClosureStep new blockClosure: self
]
