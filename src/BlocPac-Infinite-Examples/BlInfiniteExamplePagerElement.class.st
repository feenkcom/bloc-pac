Class {
	#name : #BlInfiniteExamplePagerElement,
	#superclass : #BlInfiniteElement,
	#category : #'BlocPac-Infinite-Examples'
}

{ #category : #initialization }
BlInfiniteExamplePagerElement >> defaultDataSource [
	^ BlInfiniteExamplePagerPanesDataSource new
]

{ #category : #initialization }
BlInfiniteExamplePagerElement >> defaultLayout [
	^ BlInfiniteLinearLayout new beHorizontal
]
