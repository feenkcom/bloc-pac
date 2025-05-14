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
	calc topIndex: 1.
	calc scrollOffset: 0.
	self assert: calc thumbOffset equals: 0.
	self assert: calc thumbSize equals: sizes sum.
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
	calc viewportSize: sizes sum.
	calc topIndex: 1.
	self assert: calc thumbOffset equals: 0.
	self assert: calc thumbSize equals: sizes sum.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeList [
	<gtExample>
	^Array new: 20 withAll: 50
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportAtElement5 [
	<gtExample>
	| calc sizes vpSize |
	sizes := self uniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	vpSize := sizes sum / 3.
	calc viewportSize: vpSize.
	calc topIndex: 5.
	self assert: calc thumbOffset equals: 200/3.
	self assert: calc thumbSize equals: sizes sum / 9.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportAtTop [
	<gtExample>
	| calc sizes |
	sizes := self uniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	calc viewportSize: sizes sum / 3.
	calc scrollOffset: 0.
	self assert: calc thumbOffset equals: 0.
	self assert: calc thumbSize equals: sizes sum / 9.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportAtTopWithOffset [
	<gtExample>
	| calc sizes |
	sizes := self uniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	calc viewportSize: sizes sum / 3.
	calc topIndex: 2.
	calc scrollOffset: 25.
	self assert: calc thumbOffset equals: 25/3.
	self assert: calc thumbSize equals: sizes sum / 9.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportAtTopWithOffsetThatIsTooLarge [
	<gtExample>
	| calc sizes |
	sizes := self uniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	calc viewportSize: sizes sum / 3.
	calc topIndex: 2.
	calc scrollOffset: 60.
	^ calc
]
