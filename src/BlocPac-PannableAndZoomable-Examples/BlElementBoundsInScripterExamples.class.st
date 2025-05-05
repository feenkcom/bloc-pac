Class {
	#name : #BlElementBoundsInScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'BlocPac-PannableAndZoomable-Examples'
}

{ #category : #examples }
BlElementBoundsInScripterExamples >> assertBoundsInSpaceForElement: anElement [
	| aBoundsInSpace1 aBoundsInSpace2 |
	aBoundsInSpace1 := anElement bounds inSpace.
	aBoundsInSpace2 := anElement boundsInSpace.

	self
		assertBoundsRectangle: aBoundsInSpace1 asRectangle
		equals: aBoundsInSpace2
		description: 'element bounds inSpace ({1}) ~= element boundsInSpace ({2})'
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> assertBoundsRectangle: aRectangleOne equals: aRectangleTwo description: aFormatString [
	"Format string must have two {1} {2} arguments."

	| aResult |
	aResult := aRectangleOne closeTo: aRectangleTwo precision: 0.001.
	self
		assert: aResult
		description: [ aFormatString format: { aRectangleOne. aRectangleTwo } ]
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> canvasInScripter: aScripter [
	GtJustContextStackSignal emit.
	^ self scripter: aScripter elementWithId: #'canvas'
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> canvassableElement [
	<gtExample>
	<return: #BlElement>
	| aChildBuilder |
	aChildBuilder := [ :aPosition :aSize :aColor | 
		BlElement new
			relocate: aPosition;
			size: aSize;
			geometry: BlCircleGeometry new;
			background: aColor ].

	^ BlElement new
		id: #top;
		background: (Color veryLightGray alpha: 0.3);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		padding: (BlInsets all: 10);
		addChild: (BlElement new
				id: #container;
				background: (Color veryLightGray alpha: 0.2);
				layout: BlLinearLayout horizontal;
				constraintsDo: [ :c | 
					c vertical matchParent.
					c horizontal matchParent ];
				padding: (BlInsets all: 20);
				addChild: (BlCanvassableElement new
						id: #canvas;
						background: (Color veryLightGray alpha: 0.1);
						constraintsDo: [ :c | 
							c vertical matchParent.
							c horizontal matchParent ];
						addChild: (BlElement new
									relocate: 60 @ 200;
									size: 30 @ 20;
									background: Color red)
							as: #'node-one';
						addChild: (BlElement new
									relocate: 300 @ 600;
									size: 20 @ 30;
									background: Color blue)
							as: #'node-two'))
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> containerInScripter: aScripter [
	^ self scripter: aScripter elementWithId: #'container'
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> displayCanvassableElement [
	<gtExample>
	<return: #BlScripter>
	| aScripter aCanvas |
	aScripter := self scripterWithElement: [ self canvassableElement ].

	aCanvas := self canvasInScripter: aScripter.
	self
		assert: aCanvas childrenTransformation isIdentity not
		description: [ 'Canvas transformation must not be identity.' ].
	self assert: aCanvas zoomStep equals: 1.2.

	^ aScripter
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> displayCanvassableElement_canvasBoundsInSpace [
	<gtExample>
	<return: #BlScripter>
	| aScripter anElement aBoundsInSpace |
	aScripter := self displayCanvassableElement.
	anElement := self canvasInScripter: aScripter.

	self assert: anElement bounds asRectangle equals: (20 @ 20 corner: 760 @ 560).

	aBoundsInSpace := anElement bounds inSpace.
	self assert: aBoundsInSpace asRectangle equals: (30 @ 30 corner: 770 @ 570).

	self assertBoundsInSpaceForElement: anElement.
	^ aScripter
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> displayCanvassableElement_containerBoundsInSpace [
	<gtExample>
	<return: #BlScripter>
	| aScripter anElement aBoundsInSpace |
	aScripter := self displayCanvassableElement.
	anElement := self containerInScripter: aScripter.

	self assert: anElement bounds asRectangle equals: (10 @ 10 corner: 790 @ 590).

	aBoundsInSpace := anElement bounds inSpace.
	self assert: aBoundsInSpace asRectangle equals: (10 @ 10 corner: 790 @ 590).

	self assertBoundsInSpaceForElement: anElement.

	^ aScripter
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> displayCanvassableElement_nodeOneBoundsInSpace [
	<gtExample>
	<return: #BlScripter>
	| aScripter anElement |
	aScripter := self displayCanvassableElement.
	anElement := self nodeOneInScripter: aScripter.

	self assert: anElement position equals: 60 @ 200.
	self assert: anElement extent equals: 30 @ 20.
	self assert: anElement bounds asRectangle equals: (60 @ 200 corner: 90 @ 220).

	self
		assertBoundsRectangle: anElement bounds inSpace asRectangle
		equals: (236.74418604651163 @ 30.00000000000003
				corner: 274.4186046511628 @ 55.11627906976747)
		description: 'nodeOne bounds inSpace ({1}) ~= expected {2}'.
	self assertBoundsInSpaceForElement: anElement.

	^ aScripter
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> displayCanvassableElement_nodeOneWithResizerInCanvas [
	"Assertions are correct."

	<gtExample>
	<return: #BlScripter>
	| aScripter aNodeOne aResizer aCanvas aListener |
	aScripter := self displayCanvassableElement.
	aCanvas := self canvasInScripter: aScripter.
	aNodeOne := self nodeOneInScripter: aScripter.

	aScripter do
		block: [ aResizer := BlResizerElement new preventMouseEvents zIndex: 100.
			aListener := aResizer instVarNamed: #overlayListener.
			aResizer attachTo: aNodeOne.
			aCanvas addChild: aResizer ];
		play.

	self
		assertBoundsRectangle: aResizer bounds asRectangle
		equals: (60.0 @ 200.0 corner: 90.0 @ 220.0)
		description: 'Resizer bounds ({1}) ~= {2}'.

	self
		assertBoundsRectangle: aResizer bounds inSpace asRectangle
		equals: (236.74418604651163 @ 30.00000000000003
				corner: 274.4186046511628 @ 55.11627906976747)
		description: 'Resizer bounds inSpace ({1}) ~= {2}'.
	self assertBoundsInSpaceForElement: aResizer.

	^ aScripter
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> displayCanvassableElement_nodeOneWithResizerInSpaceRoot [
	"Assertions are correct."

	<gtExample>
	<return: #BlScripter>
	| aScripter anElement aResizer |
	aScripter := self displayCanvassableElement.
	anElement := self nodeOneInScripter: aScripter.

	aScripter do
		block: [ :aParent | 
			aResizer := BlResizerElement new
					preventMouseEvents;
					zIndex: 100.
			aResizer attachTo: anElement.
			aParent addChild: aResizer ];
		onSpaceRoot;
		play.	"self
		assertBoundsRectangle: aResizer bounds asRectangle
		equals: (236.74418604651163 @ 30.00000000000003
				corner: 274.4186046511628 @ 55.11627906976747)
		description: 'Resizer bounds ({1}) ~= {2}'."

	self
		assertBoundsRectangle: aResizer bounds inSpace asRectangle
		equals: (236.74418604651163 @ 30.00000000000003
				corner: 274.4186046511628 @ 55.11627906976747)
		description: 'Resizer bounds inSpace ({1}) ~= {2}'.

	self assertBoundsInSpaceForElement: aResizer.
	^ aScripter
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> displayCanvassableElement_nodeTwoBoundsInSpace [
	<gtExample>
	<return: #BlScripter>
	| aScripter anElement aBoundsInSpace |
	aScripter := self displayCanvassableElement.
	anElement := self nodeTwoInScripter: aScripter.

	self assert: anElement position equals: 300 @ 600.
	self assert: anElement extent equals: 20 @ 30.
	self assert: anElement bounds asRectangle equals: (300 @ 600 corner: 320 @ 630).

	aBoundsInSpace := anElement bounds inSpace.
	self
		assertBoundsRectangle: aBoundsInSpace asRectangle
		equals: (538.1395348837209 @ 532.3255813953489
				corner: 563.2558139534884 @ 570.0)
		description: 'nodeTwo bounds inSpace ({1}) ~= expected {2}'.

	self assertBoundsInSpaceForElement: anElement.
	^ aScripter
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> displayCanvassableElement_topBoundsInSpace [
	<gtExample>
	<return: #BlScripter>
	| aScripter anElement aBoundsInSpace |
	aScripter := self displayCanvassableElement.
	anElement := self topInScripter: aScripter.

	self assert: anElement bounds asRectangle equals: (0 @ 0 corner: 800 @ 600).

	aBoundsInSpace := anElement bounds inSpace.
	self assert: aBoundsInSpace asRectangle equals: (0 @ 0 corner: 800 @ 600).

	self assertBoundsInSpaceForElement: anElement.

	^ aScripter
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> nodeOneInScripter: aScripter [
	^ self scripter: aScripter elementWithId: #'node-one'
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> nodeTwoInScripter: aScripter [
	^ self scripter: aScripter elementWithId: #'node-two'
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> scripter: aScripter elementWithId: aNodeId [
	| anElement |
	anElement := (aScripter root query // aNodeId) anyOne.

	self assert: anElement isNotNil.

	^ anElement
]

{ #category : #examples }
BlElementBoundsInScripterExamples >> topInScripter: aScripter [
	^ self scripter: aScripter elementWithId: #'top'
]
