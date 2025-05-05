Class {
	#name : #BlPinchableElementExamples,
	#superclass : #Object,
	#category : #'BlocPac-PannableAndZoomable-Examples'
}

{ #category : #'examples - instance creation' }
BlPinchableElementExamples >> contentElement [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		size: 300 @ 200;
		background: ((BlLinearGradientPaint direction: 1 @ 1) from: Color red to: Color blue);
		geometry: BlEllipseGeometry new
]

{ #category : #'examples - instance creation' }
BlPinchableElementExamples >> pinchableElement [
	<gtExample>
	<return: #BlPinchableElement>
	| aPinchableElement |
	aPinchableElement := BlPinchableElement new.

	self assert: aPinchableElement hasContentElement not.
	self assert: aPinchableElement constraints vertical resizer isMatchParent.
	self assert: aPinchableElement constraints horizontal resizer isMatchParent.
	self assert: aPinchableElement clipChildren.
	self assert: aPinchableElement zoomLevel equals: 1.
	self assert: aPinchableElement zoomStep equals: 0.1.

	^ aPinchableElement
]

{ #category : #'examples - pinchable' }
BlPinchableElementExamples >> pinchableElementWithContent [
	<gtExample>
	<return: #BlPinchableElement>
	| aPinchableElement |
	aPinchableElement := self pinchableElement.
	aPinchableElement background: Color lightGray.
	aPinchableElement contentElement: self contentElement.

	self assert: aPinchableElement hasContentElement.

	^ aPinchableElement
]
