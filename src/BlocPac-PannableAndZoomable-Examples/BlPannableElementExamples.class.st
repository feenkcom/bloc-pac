Class {
	#name : #BlPannableElementExamples,
	#superclass : #Object,
	#category : #'BlocPac-PannableAndZoomable-Examples'
}

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> clickableNodeStencil [
	"For the pannablePinchableGraphEditorDemo"
	<gtExample>
	<noTest>
	^ [ | node |
	node := BlElement new.
	node
		layout: BlFrameLayout new;
		geometry: (BlRectangle cornerRadius: 4);
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

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannableElement [
	<gtExample>
	| aPannableElement |
	
	aPannableElement := BlPannableElement new.

	self assert: aPannableElement hasContentElement not.
	self assert: aPannableElement constraints vertical resizer isMatchParent.
	self assert: aPannableElement constraints horizontal resizer isMatchParent.
	self assert: aPannableElement clipChildren.

	^ aPannableElement
]

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannablePinchableDemo [
	"Example by Aliaksei Syrel. Shows how bounds of parent element can automatically adjust to its children. Double-click on background to add children."

	<gtExample>
	<noTest>
	| makeNode graph graphHolder pannable |
	makeNode := self pullableNodeStencil.	"The graph element holds the actual graph nodes and edges"
	graph := BlElement new
			layout: (BlWrapAroundChildrenLayout new addLayout: BlBasicNodeBasedLayout new);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			background: Color white;
			effect: BrGlamorousShadowEffect new.
	graphHolder := BlPinchableElement new
			zoomLevel: 2;
			clipChildren: false;
			contentElement: graph;
			border: (BlBorder paint: Color black).
	pannable := graphHolder asPannableElement
			background: Color veryLightGray;
			when: BlDoubleClickEvent
				do: [ :evt | 
					| newNode |
					newNode := self pullableNodeStencil asElement.
					graph addChild: newNode.
					newNode relocate: (graphHolder globalPointToLocal: evt position) ].
	^ pannable
]

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannablePinchableGraphEditorDemo [
	"graph editor demo example using a composition of elements.
	NB: It should now be possible to create a similar demo directly using a BlCanvassableElement.

	This demo only builds a view without an underlying model, just to show in a script how to compose the key UI elements. Each element has a border or shading to make its bounds visible.
	
	- double click to create a node
	- click and drag to move it
	- double click node to inspect
	- drag the background to pan
	- control-click node or background to open a context menu
	- zoom buttons only work partially

	The graphEditor (blue border) is the root element. It holds a buttonBar and a graphContainer (orange borders). The graphContainer contains the (pinchable) graphHolder (light gray border), which holds the graph (white with shading).
	The graph element (white with shading) holds the actual graph nodes. It adapts its size to its children with a BlWrapAroundChildrenLayout layout.
	The graphHolder (gray border) is a pinchable container for the graph. See BlPinchableElement. Note that the graph it contains may overlap its own border, so we don't care about the gray border when zooming or resizing.
	The graphContainer (orange border) supports panning and handles the background events for the graph (context menu and node creation).
	"

	<gtExample>
	<noTest>
	| padding margin graphEditor graph buttonBar graphHolder graphContainer |
	padding := 2.
	margin := padding.


	graph := BlElement new
			layout: (BlWrapAroundChildrenLayout new addLayout: BlBasicNodeBasedLayout new);
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			padding: (BlInsets all: padding);
			margin: (BlInsets all: margin);
			background: Color white;
			effect: BrGlamorousShadowEffect new;
			yourself.

	graphHolder := BlPinchableElement new
			zoomLevel: 2;
			clipChildren: false;
			contentElement: graph;
			border: (BlBorder paint: Color lightGray);
			yourself.

	graphContainer := graphHolder asPannableElement
			border: (BlBorder paint: Color orange);
			padding: (BlInsets all: padding);
			margin: (BlInsets all: margin);
			when: BlDoubleClickEvent
				do: [ :evt | 
					| newNode |
					newNode := self clickableNodeStencil asElement.
					graph addChild: newNode.
					newNode relocate: (graphHolder globalPointToLocal: evt position) ];
			aptitude: (BrGlamorousWithContextMenuAptitude
					content: [ BrGlamorousSimpleContextMenuContent new
							items: {'Inspect graph' -> [ graph inspect ]};
							yourself ]);
			yourself.

	buttonBar := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical fitContent ];
			padding: (BlInsets all: padding);
			margin: (BlInsets all: margin);
			layout: BlLinearLayout horizontal;
			border: (BlBorder paint: Color orange width: 1);
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousIcons zoomin;
					label: 'Zoom In';
					action: [ graphContainer zoomIn ]);
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousIcons zoomout;
					label: 'Zoom Out';
					action: [ graphContainer zoomOut ]);
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousIcons zoomtofit;
					label: 'Fit';
					action: [ graphContainer zoomToFit ]);
			addChild: (BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousIcons actualsize;
					label: 'Resize';
					action: [ graphContainer zoomToActualSize ]).

	graphEditor := BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ];
			padding: (BlInsets all: padding);
			margin: (BlInsets all: margin);
			layout: BlLinearLayout vertical;
			border: (BlBorder paint: Color blue width: 1);
			addChild: buttonBar;
			addChild: graphContainer;
			yourself.

	^ graphEditor
]

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannableWithForm [
	<gtExample>
	| form element aPannableElement |

	form := (Form extent: 50@50 depth: 32) fillColor: Color veryLightGray.
	form fill: (10@10 corner: 40@40) fillColor: Color gray.
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
	| aPannableElement |

	aPannableElement := self pannableWithForm.
	aPannableElement size: 800@400.
	aPannableElement forceLayout.

	self assert: aPannableElement extent equals: 800@400.
	self assert: aPannableElement zoomLevel equals: 8.
	
	self assert: aPannableElement contentElement extent equals: 50@50.
	self assert: aPannableElement contentElement position equals: 375@175.
	self assert: aPannableElement contentElement transformation matrix decomposition scale asPoint equals: 8 asPoint.
	self assert: aPannableElement contentElement transformation matrix decomposition translation asPoint equals: 175 negated asPoint.


	^ aPannableElement
]

{ #category : #'examples - instance creation' }
BlPannableElementExamples >> pannableWithFormExactSizeSquare [
	<gtExample>
	| aPannableElement |

	aPannableElement := self pannableWithForm.
	aPannableElement size: 400@400.	
	aPannableElement forceLayout.

	self assert: aPannableElement extent equals: 400@400.
	self assert: aPannableElement zoomLevel equals: 8.
	
	self assert: aPannableElement contentElement extent equals: 50@50.
	self assert: aPannableElement contentElement position equals: 175 asPoint.
	self assert: aPannableElement contentElement transformation matrix decomposition scale asPoint equals: 8 asPoint.
	self assert: aPannableElement contentElement transformation matrix decomposition translation asPoint equals: 175 negated asPoint.

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
