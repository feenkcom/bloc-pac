Extension { #name : #BlElement }

{ #category : #'*BlocPac-ElementQuery' }
BlElement >> query [
	^ BlElementEagerQuery new forMany: self
]
