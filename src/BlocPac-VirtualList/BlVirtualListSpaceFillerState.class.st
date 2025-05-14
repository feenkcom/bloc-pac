Class {
	#name : #BlVirtualListSpaceFillerState,
	#superclass : #Object,
	#instVars : [
		'filledElements',
		'itemCount',
		'totalHeight',
		'totalWidth',
		'currentDataSourceIndex',
		'availableHeight',
		'startDataSourceIndex',
		'currentPosition'
	],
	#category : #'BlocPac-VirtualList'
}

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
	^ filledElements
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :theElements | theElements first measuredPosition y max: 0.0 ]
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> availableSpaceBelowLast [
	^ filledElements
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :theElements | totalHeight - theElements last measuredBounds bottom ]
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
	^ filledElements
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> filledElements: anObject [
	filledElements := anObject
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> filledElementsMeasuredBounds [
	^ self filledElements collect: [ :each | each measuredBounds asRectangle ] as: Array
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

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> initialize [
	super initialize.
	
	filledElements := LinkedList new
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
BlVirtualListSpaceFillerState >> postCopy [
	filledElements := filledElements copy
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> shouldFillDown [
	^ self availableSpaceBelowLast > 0 and: [ self startDataSourceIndex < self itemCount ]
]

{ #category : #'as yet unclassified' }
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
