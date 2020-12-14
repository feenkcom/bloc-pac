Extension { #name : #String }

{ #category : #'*BlocPac-ElementQuery' }
String >> asElementQuerySelector [
	^ BlElementQueryByIdStep new elementId: self
]
