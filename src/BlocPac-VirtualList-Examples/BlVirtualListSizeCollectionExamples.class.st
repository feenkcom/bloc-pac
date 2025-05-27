Class {
	#name : #BlVirtualListSizeCollectionExamples,
	#superclass : #Object,
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #examples }
BlVirtualListSizeCollectionExamples >> differentSizesWithGapsFullChecking [
	<gtExample>
	| sizes |
	sizes := BlVirtualListSizeCollection new.
	sizes from: 6 to: 10 size: 20.
	sizes from: 16 to: 20 size: 30.
	sizes count: 25.
	self assert: sizes count equals: 25.
	self assert: sizes averageSize equals: 25.
	#(0 25 50 75 100 125 145 165 185 205 225 250 275 300 325 350 380 410 440 470 500 525 550 575 600 625) withIndexDo: [:each :i |
		self assert: (sizes sizeUpTo: i) equals: each].
	^sizes
]

{ #category : #examples }
BlVirtualListSizeCollectionExamples >> fromExplicitSizes [
	<gtExample>
	| sizes |
	sizes := BlVirtualListSizeCollection fromSizes: #(10 10 20 10).
	self assert: sizes count equals: 4.
	self assert: sizes totalSize equals: 50.
	self assert: sizes averageSize equals: 12.5.
	self assert: (sizes sizeUpTo: 4) equals: 40.
	^sizes
]

{ #category : #examples }
BlVirtualListSizeCollectionExamples >> simpleUniformComplete [
	<gtExample>
	| sizes |
	sizes := BlVirtualListSizeCollection new.
	sizes from: 1 to: 10 size: 20.
	self assert: sizes count equals: 10.
	self assert: sizes totalSize equals: 200.
	self assert: sizes averageSize equals: 20.
	self assert: (sizes sizeUpTo: 6) equals: 100.
	^sizes
]

{ #category : #examples }
BlVirtualListSizeCollectionExamples >> simpleUniformMissingBeginning [
	<gtExample>
	| sizes |
	sizes := BlVirtualListSizeCollection new.
	sizes from: 11 to: 20 size: 20.
	self assert: sizes count equals: 20.
	self assert: sizes totalSize equals: 400.
	self assert: sizes averageSize equals: 20.
	self assert: (sizes sizeUpTo: 6) equals: 100.
	self assert: (sizes sizeUpTo: 16) equals: 300.
	^sizes
]

{ #category : #examples }
BlVirtualListSizeCollectionExamples >> simpleUniformMissingBeginningWithTwoDifferentSizes [
	<gtExample>
	| sizes |
	sizes := BlVirtualListSizeCollection new.
	sizes from: 11 to: 20 size: 20.
	sizes from: 21 to: 30 size: 30.
	self assert: sizes count equals: 30.
	self assert: sizes averageSize equals: 25.
	self assert: sizes totalSize equals: (25*10)+(20*10)+(30*10).
	self assert: (sizes sizeUpTo: 6) equals: 125.
	self assert: (sizes sizeUpTo: 16) equals: (25*10)+(20*5).
	^sizes
]

{ #category : #examples }
BlVirtualListSizeCollectionExamples >> simpleUniformMissingEnd [
	<gtExample>
	| sizes |
	sizes := BlVirtualListSizeCollection new.
	sizes from: 1 to: 10 size: 20.
	sizes count: 20.
	self assert: sizes count equals: 20.
	self assert: sizes totalSize equals: 400.
	self assert: sizes averageSize equals: 20.
	^sizes
]
