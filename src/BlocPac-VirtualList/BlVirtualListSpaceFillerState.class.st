Class {
	#name : #BlVirtualListSpaceFillerState,
	#superclass : #Object,
	#instVars : [
		'itemCount',
		'totalHeight',
		'totalWidth',
		'currentDataSourceIndex',
		'availableHeight',
		'startDataSourceIndex',
		'currentPosition',
		'filledItems',
		'measurementViewport'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> addFilledElementFirst: anElement dataSourceIndex: aDataSourceIndex [
	filledItems addFirst: (BlVirtualListFilledItem new
		dataSourceIndex: aDataSourceIndex;
		element: anElement;
		bounds: anElement measuredBounds asRectangle)
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> addFilledElementLast: anElement dataSourceIndex: aDataSourceIndex [
	filledItems addLast: (BlVirtualListFilledItem new
		dataSourceIndex: aDataSourceIndex;
		element: anElement;
		bounds: anElement measuredBounds asRectangle)
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> availableHeight [
	^ availableHeight
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> availableHeight: anObject [
	availableHeight := anObject
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> availableSpaceAboveFirst [
	^ filledItems
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :theItems | theItems first bounds top max: 0.0 ]
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> availableSpaceBelowLast [
	^ filledItems
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :theElements | availableHeight - theElements last bounds bottom ]
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> currentDataSourceIndex [
	^ currentDataSourceIndex
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> currentDataSourceIndex: anObject [
	currentDataSourceIndex := anObject
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> currentPosition [
	^ currentPosition
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> currentPosition: anObject [
	currentPosition := anObject
]

{ #category : #views }
BlVirtualListSpaceFillerState >> filledElementBoundsAssertion [
	| source coder |
	source := '
	self assert: self filledElementsMeasuredBounds equals: {1}'
			format: {self filledElementsMeasuredBounds printString}.

	coder := GtPharoSnippetCoder forSource: source.
	coder format.
	^ coder currentSourceString
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> filledElements [
	^ filledItems
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> filledElements: anObject [
	self
		assert: [ anObject isKindOf: OrderedCollection ]
		description: [ 'Private api, must be an OrderedCollection' ].

	filledItems := anObject
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> filledElementsMeasuredBounds [
	^ self filledElements collect: [ :each | each bounds ] as: Array
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> firstVisibleFilledItem [
	<return: #BlVirtualListFilledItem or: nil>
	
	^ filledItems
		ifEmpty: [ nil ]
		ifNotEmpty: [ :allItems |
			allItems do: [ :eachItem |
				eachItem bounds bottom > 0
				 	ifTrue: [ ^ eachItem ] ].
			allItems first ]
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> firstVisibleFilledItemTop [
	^ self firstVisibleFilledItem
		ifNil: [ 0 ]
		ifNotNil: [ :aFilledItem | aFilledItem bounds top ].
]

{ #category : #views }
BlVirtualListSpaceFillerState >> gtFilledElementsBoundsAssertionFor: aView [
	<gtView>
	^ aView explicit
		title: 'Bounds assertion';
		priority: 15;
		stencil: [ | source coder coderViewModel |
			source := self filledElementBoundsAssertion.
			coder := GtPharoSnippetCoder forSource: source.
			coderViewModel := coder asCoderViewModel.
			coderViewModel selfObject: self.
			coderViewModel asExpandedOnlyElement matchParent ]
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> gtNewDistanceMarker: distance from: position color: color [
	| state distanceMarker distanceLabel |
	distanceMarker := BlElement new
			geometry: (BlNormalizedMultiPolylineGeometry
					polylines: {{0 @ 0.
								1 @ 0}.
							{0.5 @ 0.
								0.5 @ 1}.
							{0 @ 1.
								1 @ 1}});
			height: (distance max: 0) - 1;
			width: 10;
			outskirts: BlOutskirts centered;
			border: (BlBorder paint: color width: 2).

	distanceLabel := BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			text: distance asString , 'pt'.

	state := BrFrame new
			hFitContent;
			clipChildren: false;
			vMatchParent.

	state
		addChild: (BrHorizontalPane new
				alignCenter;
				vExact: (distance max: 0);
				hFitContent;
				clipChildren: false;
				margin: (BlInsets top: (position + (distance min: 0)) left: 10);
				addChildren: {distanceMarker.
						distanceLabel}).
	^ state
]

{ #category : #initialization }
BlVirtualListSpaceFillerState >> initialize [
	super initialize.
	
	filledItems := OrderedCollection new
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> itemCount [
	^ itemCount
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> itemCount: anObject [
	itemCount := anObject
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> lastVisibleFilledItem [
	<return: #BlVirtualListFilledItem or: nil>
	
	^ filledItems
		ifEmpty: [ nil ]
		ifNotEmpty: [ :allItems |
			allItems reverseDo: [ :eachItem |
				eachItem bounds top < totalHeight
				 	ifTrue: [ ^ eachItem ] ].
			allItems last ]
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> lastVisibleFilledItemBottom [
	^ self lastVisibleFilledItem
		ifNil: [ 0 ]
		ifNotNil: [ :aFilledItem | aFilledItem bounds bottom ].
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> measurementViewport [
	^ measurementViewport
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> measurementViewport: anObject [
	measurementViewport := anObject
]

{ #category : #copying }
BlVirtualListSpaceFillerState >> postCopy [
	filledItems := filledItems copy
]

{ #category : #asserting }
BlVirtualListSpaceFillerState >> shouldFillDown [
	^ self availableSpaceBelowLast > 0 and: [ self startDataSourceIndex < self itemCount ]
]

{ #category : #asserting }
BlVirtualListSpaceFillerState >> shouldFillUp [
	^ self availableSpaceAboveFirst > 0 and: [ self startDataSourceIndex > 1 ]
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> startDataSourceIndex [
	^ startDataSourceIndex
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> startDataSourceIndex: anObject [
	startDataSourceIndex := anObject
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> totalHeight [
	^ totalHeight
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> totalHeight: anObject [
	totalHeight := anObject
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> totalWidth [
	^ totalWidth
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> totalWidth: anObject [
	totalWidth := anObject
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> viewport [
	| firstVisibleItem firstVisibleItemIndex firstVisibleItemOffset lastVisibleItem lastVisibleItemIndex lastVisibleItemOffset |
	
	firstVisibleItem := self firstVisibleFilledItem.
	lastVisibleItem := self lastVisibleFilledItem.
	
	firstVisibleItemIndex := firstVisibleItem
		ifNil: [ 0 ]
		ifNotNil: [ firstVisibleItem dataSourceIndex ].
		
	firstVisibleItemOffset := firstVisibleItem
		ifNil: [ 0 ]
		ifNotNil: [ firstVisibleItem bounds top ].
		
	lastVisibleItemIndex := lastVisibleItem
		ifNil: [ 0 ]
		ifNotNil: [ lastVisibleItem dataSourceIndex ].
		
	lastVisibleItemOffset := lastVisibleItem
		ifNil: [ 0 ]
		ifNotNil: [ lastVisibleItem bounds bottom - totalHeight ].

	^ BlVirtualListViewport new
		topItemIndex: firstVisibleItemIndex;
		topItemOffset: firstVisibleItemOffset;
		bottomItemIndex: lastVisibleItemIndex;
		bottomItemOffset: lastVisibleItemOffset
]
