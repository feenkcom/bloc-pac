"
I am an infinite element with vertical linear layout

"
Class {
	#name : #BlInfiniteExampleElement,
	#superclass : #BlInfiniteElement,
	#category : #'BlocPac-Infinite-Examples'
}

{ #category : #initialization }
BlInfiniteExampleElement >> defaultLayout [
	^ BlInfiniteLinearLayout new
]
