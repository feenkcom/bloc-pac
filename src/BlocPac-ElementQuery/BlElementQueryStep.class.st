Class {
	#name : #BlElementQueryStep,
	#superclass : #Object,
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #'api - query' }
BlElementQueryStep >> findElementsIn: aCurrentQueryResult andAddTo: aNewQueryResult [
	self subclassResponsibility
]
