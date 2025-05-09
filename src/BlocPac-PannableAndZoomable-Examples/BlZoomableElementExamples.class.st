Class {
	#name : #BlZoomableElementExamples,
	#superclass : #Object,
	#category : #'BlocPac-PannableAndZoomable-Examples'
}

{ #category : #'examples - instance creation' }
BlZoomableElementExamples >> contentElement [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 300 @ 200;
		background: ((BlLinearGradientPaint direction: 1 @ 1) from: Color red to: Color blue);
		geometry: BlEllipseGeometry new
]

{ #category : #'examples - instance creation' }
BlZoomableElementExamples >> zoomableElement [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := BlZoomableElement new.

	self assert: aZoomableElement hasContentElement not.
	self assert: aZoomableElement hasZoomLevel not.
	self assert: aZoomableElement constraints vertical resizer isMatchParent.
	self assert: aZoomableElement constraints horizontal resizer isMatchParent.
	self assert: aZoomableElement clipChildren.
	self assert: aZoomableElement zoomCenter equals: 0.5 asPoint.

	^ aZoomableElement
]

{ #category : #'examples - zoom center' }
BlZoomableElementExamples >> zoomableElementBottomLeftZoomCenter [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := self zoomableElementWithContent.
	aZoomableElement size: 600 @ 400.
	aZoomableElement zoomCenter: 0 @ 1.
	aZoomableElement forceLayout.

	self assert: aZoomableElement extent equals: 600 @ 400.
	self assert: aZoomableElement zoomLevel equals: 2.
	self assert: aZoomableElement zoomCenter equals: 0 @ 1.

	self assert: aZoomableElement contentElement extent equals: 300 @ 200.
	self assert: aZoomableElement contentElement position equals: 300 @ 0.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition scale
				asPoint
		equals: 2 asPoint.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition translation
				asPoint
		equals: (150 @ 100) negated.

	^ aZoomableElement
]

{ #category : #'examples - zoom center' }
BlZoomableElementExamples >> zoomableElementBottomRightZoomCenter [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := self zoomableElementWithContent.
	aZoomableElement size: 600 @ 400.
	aZoomableElement zoomCenter: 1 @ 1.
	aZoomableElement forceLayout.

	self assert: aZoomableElement extent equals: 600 @ 400.
	self assert: aZoomableElement zoomLevel equals: 2.
	self assert: aZoomableElement zoomCenter equals: 1 @ 1.

	self assert: aZoomableElement contentElement extent equals: 300 @ 200.
	self assert: aZoomableElement contentElement position equals: 0 @ 0.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition scale
				asPoint
		equals: 2 asPoint.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition translation
				asPoint
		equals: (150 @ 100) negated.

	^ aZoomableElement
]

{ #category : #'examples - zoom' }
BlZoomableElementExamples >> zoomableElementFitContentWithContentZoomedOut [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := self zoomableElement.
	aZoomableElement
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ].
	aZoomableElement zoomLevel: 0.5.
	aZoomableElement border: (BlBorder paint: Color gray width: 1).
	aZoomableElement addChild: self contentElement.

	self assert: aZoomableElement hasContentElement.
	self assert: aZoomableElement hasZoomLevel.
	self assert: aZoomableElement zoomCenter equals: 0.5 asPoint.

	aZoomableElement forceLayout.

	self assert: aZoomableElement extent equals: 150 @ 100.
	self assert: aZoomableElement zoomLevel equals: 0.5.
	self assert: aZoomableElement zoomCenter equals: 0.5 asPoint.

	self assert: aZoomableElement contentElement extent equals: 300 @ 200.
	self assert: aZoomableElement contentElement position equals: -75.0 @ -50.0.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition scale
				asPoint
		equals: 0.5 asPoint.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition translation
				asPoint
		equals: 75 @ 50.

	^ aZoomableElement
]

{ #category : #'examples - zoom center' }
BlZoomableElementExamples >> zoomableElementMiddleZoomCenter [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := self zoomableElementWithContent.
	aZoomableElement size: 600 @ 400.
	aZoomableElement zoomCenter: 0.5 @ 0.5.
	aZoomableElement forceLayout.

	self assert: aZoomableElement extent equals: 600 @ 400.
	self assert: aZoomableElement zoomLevel equals: 2.
	self assert: aZoomableElement zoomCenter equals: 0.5 @ 0.5.

	self assert: aZoomableElement contentElement extent equals: 300 @ 200.
	self assert: aZoomableElement contentElement position equals: 150 @ 100.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition scale
				asPoint
		equals: 2 asPoint.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition translation
				asPoint
		equals: (150 @ 100) negated.

	^ aZoomableElement
]

{ #category : #'examples - zoom center' }
BlZoomableElementExamples >> zoomableElementTopLeftZoomCenter [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := self zoomableElementWithContent.
	aZoomableElement size: 600 @ 400.
	aZoomableElement zoomCenter: 0 @ 0.
	aZoomableElement forceLayout.

	self assert: aZoomableElement extent equals: 600 @ 400.
	self assert: aZoomableElement zoomLevel equals: 2.
	self assert: aZoomableElement zoomCenter equals: 0 @ 0.

	self assert: aZoomableElement contentElement extent equals: 300 @ 200.
	self assert: aZoomableElement contentElement position equals: 300.0 @ 200.0.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition scale
				asPoint
		equals: 2 asPoint.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition translation
				asPoint
		equals: (150 @ 100) negated.

	^ aZoomableElement
]

{ #category : #'examples - zoom center' }
BlZoomableElementExamples >> zoomableElementTopRightZoomCenter [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := self zoomableElementWithContent.
	aZoomableElement size: 600 @ 400.
	aZoomableElement zoomCenter: 1 @ 0.
	aZoomableElement forceLayout.

	self assert: aZoomableElement extent equals: 600 @ 400.
	self assert: aZoomableElement zoomLevel equals: 2.
	self assert: aZoomableElement zoomCenter equals: 1 @ 0.

	self assert: aZoomableElement contentElement extent equals: 300 @ 200.
	self assert: aZoomableElement contentElement position equals: 0 @ 200.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition scale
				asPoint
		equals: 2 asPoint.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition translation
				asPoint
		equals: (150 @ 100) negated.

	^ aZoomableElement
]

{ #category : #'examples - zoom' }
BlZoomableElementExamples >> zoomableElementTwiceLargerThanContent [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := self zoomableElementWithContent.
	aZoomableElement size: 600 @ 400.
	aZoomableElement forceLayout.

	self assert: aZoomableElement extent equals: 600 @ 400.
	self assert: aZoomableElement zoomLevel equals: 2.
	self assert: aZoomableElement zoomCenter equals: 0.5 asPoint.

	self assert: aZoomableElement contentElement extent equals: 300 @ 200.
	self assert: aZoomableElement contentElement position equals: 150.0 @ 100.0.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition scale
				asPoint
		equals: 2 asPoint.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition translation
				asPoint
		equals: (150 @ 100) negated.

	^ aZoomableElement
]

{ #category : #'examples - zoom' }
BlZoomableElementExamples >> zoomableElementTwiceSmallerThanContent [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := self zoomableElementWithContent.
	aZoomableElement size: 150 @ 100.
	aZoomableElement forceLayout.

	self assert: aZoomableElement extent equals: 150 @ 100.
	self assert: aZoomableElement zoomLevel equals: 0.5.
	self assert: aZoomableElement zoomCenter equals: 0.5 asPoint.

	self assert: aZoomableElement contentElement extent equals: 300 @ 200.
	self assert: aZoomableElement contentElement position equals: -75.0 @ -50.0.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition scale
				asPoint
		equals: 0.5 asPoint.
	self
		assert: aZoomableElement contentElement transformation matrix decomposition translation
				asPoint
		equals: 75 @ 50.

	^ aZoomableElement
]

{ #category : #'examples - instance creation' }
BlZoomableElementExamples >> zoomableElementWithContent [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := self zoomableElement.
	aZoomableElement addChild: self contentElement.

	self assert: aZoomableElement hasContentElement.
	self assert: aZoomableElement hasZoomLevel not.
	self assert: aZoomableElement zoomCenter equals: 0.5 asPoint.

	^ aZoomableElement
]

{ #category : #'examples - zoom' }
BlZoomableElementExamples >> zoomableElementWithContentMatchParentNoUserZoom [
	<gtExample>
	<return: #BlZoomableElement>
	| aZoomableElement |
	aZoomableElement := self zoomableElement.
	aZoomableElement addChild: self contentElement.
	aZoomableElement border: (BlBorder paint: Color gray width: 1).

	self assert: aZoomableElement hasContentElement.
	self assert: aZoomableElement hasZoomLevel not.
	self assert: aZoomableElement zoomCenter equals: 0.5 asPoint.

	^ aZoomableElement
]
