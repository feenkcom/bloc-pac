Extension { #name : #BlElementUniqueId }

{ #category : #'*BlocPac-ElementQuery' }
BlElementUniqueId class >> asElementQuerySelector [
	^ BlElementQueryByIdStep new elementId: self
]
