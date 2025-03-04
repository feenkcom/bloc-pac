Class {
	#name : #BlCanvassableElementExamples,
	#superclass : #Object,
	#category : #'BlocPac-PannableAndZoomable-Examples'
}

{ #category : #examples }
BlCanvassableElementExamples >> autoscaledCanvassableWithTwoNodes [
	<gtExample>
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
	| aCanvassableElement |
	aCanvassableElement := self emptyCanvassableElement.
	aCanvassableElement addChild: self roundedNode.
	aCanvassableElement children first relocate: 100@ 100.
	
	self assert: aCanvassableElement children size equals: 1.
	self assert: aCanvassableElement autoScaleEnabled not.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.
	self assert: aCanvassableElement childrenTranslationFactor equals: 0 @ 0.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.

	^ aCanvassableElement
]

{ #category : #examples }
BlCanvassableElementExamples >> canvassableWithTwoNodes [
	<gtExample>
	| aCanvassableElement |
	aCanvassableElement := self canvassableWithOneNode.
	aCanvassableElement addChild: self roundedNode.
	aCanvassableElement children second relocate: 200@ 200.
	aCanvassableElement children second background: Color red.

	self assert: aCanvassableElement children size equals: 2.
	self assert: aCanvassableElement autoScaleEnabled not.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.
	self assert: aCanvassableElement childrenTranslationFactor equals: 0 @ 0.
	self assert: aCanvassableElement childrenScaleFactor equals: 1.

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
	self assert: aCanvassableElement childrenScaleFactor equals: 1.


	^ aCanvassableElement
]

{ #category : #'as yet unclassified' }
BlCanvassableElementExamples >> graphEditorDemo [
	"This demo illustrates how one might build a view for an interactive graph editor
	using a BlCanvassableElement.
	
	Note that this is only a view without an underlying model.
		
	- double click to create a node
	- click and drag to move it
	- double click node to inspect
	- drag the background to pan
	- control-click node or background to open a context menu
	
	NB: This demo replaces BlPannableElementExamples>>#pannablePinchableGraphEditorDemo."

	<gtExample>
	| padding margin graphCanvas |
	padding := 2.
	margin := padding.

	graphCanvas := BlCanvassableElement new
			constraintsDo: [ :c | 
				c vertical matchParent.
				c horizontal matchParent ];
			padding: (BlInsets all: padding);
			margin: (BlInsets all: margin);
			background: Color white;
			border: (BlBorder paint: Color red);
			when: BlDoubleClickEvent
				do: [ :evt | 
					| newNode |
					newNode := self pullableNodeStencil asElement.
					newNode relocate: evt childrenPosition.
					graphCanvas addChild: newNode. ];
			aptitude: (BrGlamorousWithContextMenuAptitude
					content: [ BrGlamorousSimpleContextMenuContent new
							items: {'Inspect graph' -> [ graphCanvas inspect ]};
							yourself ]);
			yourself.
	^ graphCanvas
]

{ #category : #'as yet unclassified' }
BlCanvassableElementExamples >> pullableNodeStencil [
	"Node for graphEditorDemo"
	<gtExample>
	^ [ | node |
	node := BlElement new.
	node
		layout: BlFrameLayout new;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		background: Color white;
		constraintsDo: [ :c | 
			c horizontal fitContent.
			c vertical fitContent ];
		padding: (BlInsets all: 10).
	node graph beNode.
	node
		aptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle border: (BlBorder paint: Color black width: 1) ];
				hovered: [ :aStyle | aStyle border: (BlBorder paint: Color red width: 1) ])
				+ ((BrGlamorousWithContextMenuAptitude
						content: [ BrGlamorousSimpleContextMenuContent new
								items: {'Inspect node' -> [ node inspect ]};
								yourself ])
						useSecondaryMouseButton;
						yourself).
	node addEventHandler: BlPullHandler new.
	node
		addEventHandler: (BlEventHandler
				on: BlDoubleClickEvent
				do: [ :evt | 
					evt consumed: true.
					node phlow spawnObject: node ]).
	node ] asStencil
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
					hovered: [ :aStyle | aStyle border: (BlBorder paint: Color red width: 1) ]);
			addEventHandler: BlPullHandler new;
			yourself.
	^ node
]
