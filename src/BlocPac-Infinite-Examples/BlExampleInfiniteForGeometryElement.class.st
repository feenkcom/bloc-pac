Class {
	#name : #BlExampleInfiniteForGeometryElement,
	#superclass : #BlInfiniteElement,
	#category : #'BlocPac-Infinite-Examples'
}

{ #category : #initialization }
BlExampleInfiniteForGeometryElement >> defaultDataSource [
	^ BlExampleInfiniteForGeometryDataSource new
]

{ #category : #initialization }
BlExampleInfiniteForGeometryElement >> defaultLayout [
	^ BlInfiniteLinearLayout vertical
]

{ #category : #initialization }
BlExampleInfiniteForGeometryElement >> initialize [
	super initialize.
	
	self background: (Color gray alpha: 0.05)
]
