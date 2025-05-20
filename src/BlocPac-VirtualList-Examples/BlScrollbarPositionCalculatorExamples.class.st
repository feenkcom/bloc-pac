Class {
	#name : #BlScrollbarPositionCalculatorExamples,
	#superclass : #Object,
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> nonuniformSizeFullViewport [
	<gtExample>
	| calc |
	calc := BlScrollbarPositionCalculator forSizes: self nonuniformSizeList.
	calc viewportSize: self nonuniformSizeListTotal.
	calc topIndex: 1.
	calc scrollOffset: 0.
	self assert: calc thumbOffset equals: 0.
	self assert: calc thumbSize equals: self nonuniformSizeListTotal.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> nonuniformSizeList [
	<gtExample>
	^#(100 50 30 60 30 30 100 100 80 100 10 30 60 30 30 100 100)
]

{ #category : #helpers }
BlScrollbarPositionCalculatorExamples >> nonuniformSizeListTotal [
	^ self nonuniformSizeList sum
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> nonuniformSizeSmallerViewport [
	<gtExample>
	| calc |
	calc := self nonuniformSizeFullViewport.
	calc viewportSize: self nonuniformSizeListTotal / 3.
	self assert: calc thumbOffset equals: 0.
	self assert: calc thumbSize equals: self nonuniformSizeListTotal / 9.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> nonuniformSizeSmallerViewportAtElement11 [
	<gtExample>
	| calc |
	calc := self nonuniformSizeSmallerViewport.
	calc topIndex: 11.
	self assert: calc thumbOffset equals: 680/3.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> nonuniformSizeSmallerViewportAtElement11WithOffset [
	<gtExample>
	| calc |
	calc := self nonuniformSizeSmallerViewportAtElement11.
	calc scrollOffset: 60.
	self assert: calc thumbOffset equals: 620/3.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> nonuniformSizeSmallerViewportAtElement5 [
	<gtExample>
	| calc |
	calc := self nonuniformSizeSmallerViewport.
	calc topIndex: 5.
	self assert: calc thumbOffset equals: 80.
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
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeFullViewport [
	<gtExample>
	| calc |
	calc := BlScrollbarPositionCalculator forSizes: self uniformSizeList.
	calc viewportSize: self uniformSizeListTotal.
	calc scrollOffset: 0.
	calc topIndex: 1.
	self assert: calc thumbOffset equals: 0.
	self assert: calc thumbSize equals: self uniformSizeListTotal.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeList [
	<gtExample>
	^Array new: 21 withAll: 50
]

{ #category : #helpers }
BlScrollbarPositionCalculatorExamples >> uniformSizeListTotal [
	^ self uniformSizeList sum
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportAtBottom [
	<gtExample>
	| calc |
	calc := self uniformSizeSmallerViewportAtTop.
	calc topIndex: 15.
	self assert: calc thumbOffset equals: 14*50/3.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportAtElement5 [
	<gtExample>
	| calc |
	calc := self uniformSizeSmallerViewportAtTop.
	calc topIndex: 5.
	self assert: calc thumbOffset equals: 200/3.
	self assert: calc thumbSize equals: self uniformSizeListTotal / 9.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportAtTop [
	<gtExample>
	| calc |
	calc := self uniformSizeFullViewport.
	calc viewportSize: self uniformSizeListTotal / 3.
	self assert: calc thumbOffset equals: 0.
	self assert: calc thumbSize equals: self uniformSizeListTotal / 9.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportAtTopWithOffset [
	<gtExample>
	| calc |
	calc := self uniformSizeSmallerViewportAtTop.
	calc topIndex: 2.
	calc scrollOffset: 25.
	self assert: calc thumbOffset equals: 25/3.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportAtTopWithOffsetThatIsTooLarge [
	"If offset is too big, it will just draw rather than throw an error"

	<gtExample>
	| calc |
	calc := self uniformSizeSmallerViewportAtTop.
	calc topIndex: 3.
	calc scrollOffset: 60.
	self assert: calc thumbOffset equals: 40/3.
	^ calc
]

{ #category : #examples }
BlScrollbarPositionCalculatorExamples >> uniformSizeSmallerViewportOffEnd [
	<gtExample>
	| calc |
	calc := self uniformSizeSmallerViewportAtTop.
	calc topIndex: 21.
	self assert: calc thumbOffset equals: 20*50/3.
	^ calc
]
