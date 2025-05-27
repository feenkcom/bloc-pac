Class {
	#name : #BlVirtualListSizeCollectionExamples,
	#superclass : #Object,
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #examples }
BlVirtualListSizeCollectionExamples >> simpleUniformComplete [
	<gtExample>
	| sizes |
	sizes := BlVirtualListSizeCollection new.
	sizes from: 1 to: 10 size: 20.
	self assert: sizes count equals: 10.
	self assert: sizes totalSize equals: 200.
	self assert: sizes averageSize equals: 20.
	self assert: (sizes sizeUpTo: 5) equals: 100.
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
	self assert: (sizes sizeUpTo: 5) equals: 100.
	self assert: (sizes sizeUpTo: 15) equals: 300.
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
	self assert: (sizes sizeUpTo: 5) equals: 125.
	self assert: (sizes sizeUpTo: 15) equals: (25*10)+(20*5).
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
