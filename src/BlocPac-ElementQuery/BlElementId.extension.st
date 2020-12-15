Extension { #name : #BlElementId }

{ #category : #'*BlocPac-ElementQuery' }
BlElementId >> asElementQuerySelector [
	^ BlElementQueryByIdStep new elementId: self
]
