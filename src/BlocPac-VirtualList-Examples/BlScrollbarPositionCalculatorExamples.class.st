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
BlScrollbarPositionCalculatorExamples >> nonuniformSizeSmallerViewportAtElement5 [
	<gtExample>
	| calc sizes vpSize |
	sizes := self nonuniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	vpSize := sizes sum / 3.
	calc viewportSize: vpSize.
	calc topIndex: 5.
	self assert: calc thumbOffset equals: 80.
	self assert: calc thumbSize equals: sizes sum / 9.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> nonuniformSizeSmallerViewportAtElement7 [
	<gtExample>
	| calc sizes vpSize |
	sizes := self nonuniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	vpSize := sizes sum / 3.
	calc viewportSize: vpSize.
	calc topIndex: 7.
	self assert: calc thumbOffset equals: 100.
	self assert: calc thumbSize equals: sizes sum / 9.
	^ calc
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
	^Array new: 21 withAll: 50
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportAtBottom [
	<gtExample>
	| calc sizes |
	sizes := self uniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	calc viewportSize: sizes sum / 3.
	calc scrollOffset: 0.
	calc topIndex: 15.
	self assert: calc thumbOffset equals: 14*50/3.
	self assert: calc thumbSize equals: sizes sum / 9.
	^ calc
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
	"If offset is too big, it will just draw rather than throw an error"

	<gtExample>
	| calc sizes |
	sizes := self uniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	calc viewportSize: sizes sum / 3.
	calc topIndex: 3.
	calc scrollOffset: 60.
	self assert: calc thumbOffset equals: 40/3.
	self assert: calc thumbSize equals: sizes sum / 9.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportOffEnd [
	<gtExample>
	| calc sizes |
	sizes := self uniformSizeList.
	calc := BlScrollbarPositionCalculator forSizes: sizes.
	calc viewportSize: sizes sum / 3.
	calc scrollOffset: 0.
	calc topIndex: 21.
	self assert: calc thumbOffset equals: 20*50/3.
	self assert: calc thumbSize equals: sizes sum / 9.
	^ calc
]
