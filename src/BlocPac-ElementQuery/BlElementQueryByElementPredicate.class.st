Class {
	#name : #BlElementQueryByElementPredicate,
	#superclass : #BlElementQueryByPredicate,
	#instVars : [
		'element'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #accessing }
BlElementQueryByElementPredicate >> element [
	^ element
]

{ #category : #accessing }
BlElementQueryByElementPredicate >> element: aBlElementOrBlock [
	element := aBlElementOrBlock
]

{ #category : #'api - query' }
BlElementQueryByElementPredicate >> findElementsIn: aCurrentQueryResult andAddTo: aNewQueryResult [
	aNewQueryResult addElement: self element value
]

{ #category : #printing }
BlElementQueryByElementPredicate >> printOn: aStream [
	super printOn: aStream.
	
	aStream space; print: self element
]
