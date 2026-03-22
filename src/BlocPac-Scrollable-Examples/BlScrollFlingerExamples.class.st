"
I contain examples of the scroll flinger

"
Class {
	#name : #BlScrollFlingerExamples,
	#superclass : #Object,
	#category : #'BlocPac-Scrollable-Examples'
}

{ #category : #'examples - instance creation' }
BlScrollFlingerExamples >> scrollContent [
	<gtExample>
	<return: #BlElement>
	^ BlElement new
		background: (Color blue alpha: 0.2);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 1000 ]
]

{ #category : #'examples - instance creation' }
BlScrollFlingerExamples >> scrollFlinger [
	<gtExample>
	<return: #BlScrollFlinger>
	| aFlinger |
	aFlinger := BlScrollFlinger new.
	self assert: aFlinger interpolator equals: BlQuinticInterpolator default.

	^ aFlinger
]

{ #category : #examples }
BlScrollFlingerExamples >> scrollFlingerOnScrollPane [
	<gtExample>
	<return: #BlScrollFlinger>
	^ self scrollFlinger initializeWith: self scrollPaneWithContent
]

{ #category : #'examples - instance creation' }
BlScrollFlingerExamples >> scrollPane [
	<gtExample>
	<return: #BlScrollableElement>
	^ BlScrollableElement new
		size: 300 @ 500;
		clipChildren: false;
		border: (BlBorder builder dashed
				paint: Color gray;
				width: 2;
				build)
]

{ #category : #examples }
BlScrollFlingerExamples >> scrollPaneWithContent [
	<gtExample>
	<return: #BlScrollableElement>
	^ self scrollPane addChild: self scrollContent
]

{ #category : #'examples - smooth scroll' }
BlScrollFlingerExamples >> smoothScrollDown [
	<gtExample>
	<return: #BlScrollableElement>
	| aFlinger |
	aFlinger := self scrollFlingerOnScrollPane.
	aFlinger smoothScrollBy: 0 @ 500 during: 2 seconds.
	^ aFlinger scrollable
]

{ #category : #'examples - smooth scroll' }
BlScrollFlingerExamples >> smoothScrollUp [
]
