Class {
	#name : #BlPannableElementExamples,
	#superclass : #Object,
	#category : #'BlocPac-PannableAndZoomable-Examples'
}

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannableElement [
	<gtExample>
	<return: #BlPannableElement>
	| aPannableElement |
	aPannableElement := BlPannableElement new.

	self assert: aPannableElement hasContentElement not.
	self assert: aPannableElement constraints vertical resizer isMatchParent.
	self assert: aPannableElement constraints horizontal resizer isMatchParent.
	self assert: aPannableElement clipChildren.

	^ aPannableElement
]

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannableWithForm [
	<gtExample>
	<return: #BlPannableElement>
	| form element aPannableElement |
	form := (Form extent: 50 @ 50 depth: 32) fillColor: Color veryLightGray.
	form fill: (10 @ 10 corner: 40 @ 40) fillColor: Color gray.
	element := BlElement new
			size: form extent;
			background: form.

	aPannableElement := BlPannableElement new.
	aPannableElement contentElement: element.

	self assert: aPannableElement contentElement equals: element.
	self assert: aPannableElement zoomLevel equals: 1.0.

	^ aPannableElement
]

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannableWithFormExactSize [
	<gtExample>
	<return: #BlPannableElement>
	| aPannableElement |
	aPannableElement := self pannableWithForm.
	aPannableElement size: 800 @ 400.
	aPannableElement forceLayout.

	self assert: aPannableElement extent equals: 800 @ 400.
	self assert: aPannableElement zoomLevel equals: 8.

	self assert: aPannableElement contentElement extent equals: 50 @ 50.
	self assert: aPannableElement contentElement position equals: 375 @ 175.
	self
		assert: aPannableElement contentElement transformation matrix decomposition scale
				asPoint
		equals: 8 asPoint.
	self
		assert: aPannableElement contentElement transformation matrix decomposition translation
				asPoint
		equals: 175 negated asPoint.


	^ aPannableElement
]

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannableWithFormExactSizeSquare [
	<gtExample>
	<return: #BlPannableElement>
	| aPannableElement |
	aPannableElement := self pannableWithForm.
	aPannableElement size: 400 @ 400.
	aPannableElement forceLayout.

	self assert: aPannableElement extent equals: 400 @ 400.
	self assert: aPannableElement zoomLevel equals: 8.

	self assert: aPannableElement contentElement extent equals: 50 @ 50.
	self assert: aPannableElement contentElement position equals: 175 asPoint.
	self
		assert: aPannableElement contentElement transformation matrix decomposition scale
				asPoint
		equals: 8 asPoint.
	self
		assert: aPannableElement contentElement transformation matrix decomposition translation
				asPoint
		equals: 175 negated asPoint.

	^ aPannableElement
]

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pullableNodeStencil [
	"For the pannablePinchableDemo"
	<gtExample>
	<noTest>
	^ [ | node |
	node := BlElement new
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			border: (BlBorder paint: Color black width: 2);
			background: Color white;
			size: 20 @ 20;
			addEventHandler: BlPullHandler new ] asStencil
]
