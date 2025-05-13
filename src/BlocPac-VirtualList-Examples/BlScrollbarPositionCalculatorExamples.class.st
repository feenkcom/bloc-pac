Class {
	#name : #BlScrollbarPositionCalculatorExamples,
	#superclass : #Object,
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> nonuniformSizeFullViewport [
	<gtExample>
	| calc sizes |
	sizes := self nonuniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	calc viewportSize: sizes sum.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> nonuniformSizeList [
	<gtExample>
	^#(100 50 30 60 30 30 100 100 80 100 10 30 60 30 30 100 100)
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeFullViewport [
	<gtExample>
	| calc sizes |
	sizes := self uniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	calc viewportSize: sizes sum.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeList [
	<gtExample>
	^Array new: 20 withAll: 50
]
