Extension { #name : #Association }

{ #category : #'*BlocPac-ElementQuery' }
Association >> asElementQueryPredicate [
	^ BlElementQueryByElementPropertyPredicate new 
		propertyName: self key;
		propertyValue: self value
]
