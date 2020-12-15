Extension { #name : #Behavior }

{ #category : #'*BlocPac-ElementQuery' }
Behavior >> asElementQuerySelector [
	^ BlElementQueryByClassStep new elementClass: self
]
