Class {
	#name : #BlCanvassableElementExamples,
	#superclass : #Object,
	#category : #'BlocPac-PannableAndZoomable-Examples'
}

{ #category : #examples }
BlCanvassableElementExamples >> canvassableWithOneNode [
	<gtExample>
	| aCanvassableElement |
	aCanvassableElement := self emptyCanvassableElement.
	aCanvassableElement addChild: self roundedNode.
	aCanvassableElement children first relocate: 100@ 100.
	
	self assert: aCanvassableElement children size equals: 1.
	self assert: aCanvassableElement autoScaleEnabled not.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.
	self assert: aCanvassableElement childrenTranslationFactor equals: 0 @ 0.
	self assert: aCanvassableElement automaticScaleFactor equals: 0 @ 0 -> 1.
	self assert: aCanvassableElement automaticTranslationFactor equals: 0 @ 0.

	^ aCanvassableElement
]

{ #category : #examples }
BlCanvassableElementExamples >> canvassableWithTwoNodes [
	<gtExample>
	| aCanvassableElement |
	aCanvassableElement := self canvassableWithOneNode.
	aCanvassableElement addChild: self roundedNode.
	aCanvassableElement children second relocate: 200@ 200.

	self assert: aCanvassableElement children size equals: 2.
	self assert: aCanvassableElement autoScaleEnabled not.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.
	self assert: aCanvassableElement childrenTranslationFactor equals: 0 @ 0.
	self assert: aCanvassableElement automaticScaleFactor equals: 0 @ 0 -> 1.
	self assert: aCanvassableElement automaticTranslationFactor equals: 0 @ 0.

	^ aCanvassableElement
]

{ #category : #examples }
BlCanvassableElementExamples >> emptyCanvassableElement [
	<gtExample>
	| aCanvassableElement |
	aCanvassableElement := BlCanvassableElement new
			background: Color white;
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ].

	self assert: aCanvassableElement children size equals: 0.
	self assert: aCanvassableElement autoScaleEnabled not.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.
	self assert: aCanvassableElement childrenTranslationFactor equals: 0 @ 0.
	self assert: aCanvassableElement automaticScaleFactor equals: 0 @ 0 -> 1.
	self assert: aCanvassableElement automaticTranslationFactor equals: 0 @ 0.


	^ aCanvassableElement
]

{ #category : #examples }
BlCanvassableElementExamples >> roundedNode [
	<gtExample>
	| node |
	node := BlElement new
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
			background: Color white;
			size: 25 @ 25;
			border: (BlBorder paint: Color black width: 2);
			aptitude: (BrStyleCommonAptitude new
					default: [ :aStyle | aStyle border: (BlBorder paint: Color black width: 1) ];
					hovered: [ :aStyle | aStyle border: (BlBorder paint: Color red width: 1) ]).
	^ node
]
