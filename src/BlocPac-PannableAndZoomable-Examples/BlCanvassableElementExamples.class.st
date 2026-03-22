Class {
	#name : #BlCanvassableElementExamples,
	#superclass : #Object,
	#category : #'BlocPac-PannableAndZoomable-Examples'
}

{ #category : #examples }
BlCanvassableElementExamples >> autoscaledCanvassableWithTwoNodes [
	<gtExample>
	<return: #BlCanvassableElement>
	| aCanvassableElement |
	aCanvassableElement := self canvassableWithTwoNodes.
	aCanvassableElement enableAutoScale.

	self assert: aCanvassableElement children size equals: 2.
	self assert: aCanvassableElement autoScaleEnabled.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.
	self assert: aCanvassableElement childrenTranslationFactor equals: 0 @ 0.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.

	^ aCanvassableElement
]

{ #category : #examples }
BlCanvassableElementExamples >> canvassableWithOneNode [
	<gtExample>
	<return: #BlCanvassableElement>
	| aCanvassableElement |
	aCanvassableElement := self emptyCanvassableElement.
	aCanvassableElement addChild: self roundedNode.
	aCanvassableElement children first relocate: 100 @ 100.

	self assert: aCanvassableElement children size equals: 1.
	self assert: aCanvassableElement autoScaleEnabled.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.
	self assert: aCanvassableElement childrenTranslationFactor equals: 0 @ 0.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.

	^ aCanvassableElement
]

{ #category : #examples }
BlCanvassableElementExamples >> canvassableWithTwoNodes [
	<gtExample>
	<return: #BlCanvassableElement>
	| aCanvassableElement |
	aCanvassableElement := self canvassableWithOneNode.
	aCanvassableElement addChild: self roundedNode.
	aCanvassableElement children second relocate: 200 @ 200.
	aCanvassableElement children second background: Color red.

	self assert: aCanvassableElement children size equals: 2.
	self assert: aCanvassableElement autoScaleEnabled.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.
	self assert: aCanvassableElement childrenTranslationFactor equals: 0 @ 0.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.

	^ aCanvassableElement
]

{ #category : #examples }
BlCanvassableElementExamples >> emptyCanvassableElement [
	<gtExample>
	<return: #BlCanvassableElement>
	| aCanvassableElement |
	aCanvassableElement := BlCanvassableElement new
			background: Color white;
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ].

	self assert: aCanvassableElement children size equals: 0.
	self assert: aCanvassableElement autoScaleEnabled.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.
	self assert: aCanvassableElement childrenTranslationFactor equals: 0 @ 0.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.


	^ aCanvassableElement
]
