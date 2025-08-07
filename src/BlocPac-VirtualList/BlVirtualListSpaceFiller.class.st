"
{{gtClass:BlVirtualListSpaceFiller}} is used within a virtualized list to occupy space that is not filled by actual content elements. It allows the virtual list to maintain the correct scrollable area size and positioning, even as only a subset of elements are rendered.
"
Class {
	#name : #BlVirtualListSpaceFiller,
	#superclass : #Object,
	#traits : 'TBlWithLayoutMeasurement',
	#classTraits : 'TBlWithLayoutMeasurement classTrait',
	#instVars : [
		'fetcher',
		'anchor',
		'measurementSpec',
		'totalHeight',
		'totalWidth',
		'availableHeight'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #views }
BlVirtualListSpaceFiller >> asPreviewElement [
	| container steps |

	steps := OrderedCollection new.
	self fillSpaceAndDo: [ :eachState | steps add: eachState copy ].

	container := BrHorizontalFlow new
		vFitContent;
		hMatchParent.

	steps
		do: [ :each | 
			container
				addChild: (each asPreviewElement asScalableElement
						clipChildren: false;
						when: BlClickEvent
						do: [ :anEvent | anEvent currentTarget phlow spawnObject: each ];
						constraintsDo: [ :c | 
							c horizontal exact: 300.
							c vertical fitContent ];
						fitWidth;
						margin: (BlInsets all: 20)) ].

	^ container asScrollableElement
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFiller >> attachedElements: aDictionary [
	fetcher attachedElements: aDictionary
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> cleanUpSpace: initialState andEachStepDo: eachStateBlock [
	| listViewport visibleItems |
	
	listViewport := initialState viewport.
	
	visibleItems := initialState filledItems
		select: [ :eachItem |
			eachItem dataSourceIndex
				between: listViewport topItemIndex
				and: listViewport bottomItemIndex ].
				
	measurementSpec viewport ifNotNil: [ :aViewport |
		visibleItems := initialState filledItems
			select: [ :eachItem | eachItem bounds intersects: aViewport bounds ] ].

	initialState filledItems: visibleItems.
	eachStateBlock cull: initialState
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> createFillerAnchorState: aFillerAnchor [
	^ BlVirtualListSpaceFillerAnchorState new
		elementAlignment: aFillerAnchor elementAlignment;
		startDataSourceIndex: aFillerAnchor dataSourceIndex;
		currentDataSourceIndex: aFillerAnchor dataSourceIndex;
		currentPosition: aFillerAnchor offset;
		itemCount: fetcher dataSource itemCount;
		availableHeight: availableHeight;
		totalWidth: totalWidth;
		totalHeight: totalHeight;
		measurementViewport: measurementSpec viewport;
		measuredHeight: BlVirtualListFillerMeasuredHeight new;
		yourself
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpace [
	^ self fillSpaceAndDo: [ :eachState | ]
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpaceAnchor: aFillerAnchorState andEachStepDo: aBlock [
	aBlock cull: aFillerAnchorState.
	self tryFillAnchor: aFillerAnchorState.
	aBlock cull: aFillerAnchorState.
	
	^ aFillerAnchorState
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpaceAndDo: eachStateBlock [
	| initialState fillStart filledHeight |
	
	initialState := self
		fillSpaceAnchor: (self createFillerAnchorState: anchor)
		andEachStepDo: eachStateBlock.

	initialState shouldFillUp
		ifTrue: [ self fillSpaceUp: initialState asFillUpState andEachStepDo: eachStateBlock ].

	initialState shouldFillDown
		ifTrue: [ self fillSpaceDown: initialState asFillDownState andEachStepDo: eachStateBlock ].
		
	fillStart := initialState firstVisibleFilledItemTop.
	filledHeight := initialState lastVisibleFilledItemBottom - fillStart.
	filledHeight := filledHeight + fillStart max: 0.
	
	initialState measuredHeight: (BlVirtualListFillerMeasuredHeight new += filledHeight).

	self
		cleanUpSpace: initialState
		andEachStepDo: eachStateBlock.

	^ initialState
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpaceDown: aFillerDownState andEachStepDo: aBlock [
	aBlock cull: aFillerDownState.

	[ | shouldContinue |
	shouldContinue := self tryFillNextSpaceDown: aFillerDownState.
	shouldContinue ifTrue: [ aBlock cull: aFillerDownState ].
	shouldContinue ] whileTrue.
	^ aFillerDownState
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpaceUp: aFillerUpState andEachStepDo: aBlock [
	aBlock cull: aFillerUpState.

	[ | shouldContinue |
	shouldContinue := self tryFillNextSpaceUp: aFillerUpState.
	shouldContinue ifTrue: [ aBlock cull: aFillerUpState ].
	shouldContinue ] whileTrue.
	
	^ aFillerUpState
]

{ #category : #views }
BlVirtualListSpaceFiller >> gtStepsFor: aView [
	<gtView>
	^ aView forward
		title: 'Steps';
		priority: 5;
		object: [ self asPreviewElement ];
		view: #gtLiveFor:;
		actionUpdateButton
]

{ #category : #initialization }
BlVirtualListSpaceFiller >> setFetcher: aFetcher anchor: anAnchor measurementSpec: aMeasurementSpec [
	fetcher := aFetcher.
	anchor := anAnchor.
	measurementSpec := aMeasurementSpec.

	totalWidth := measurementSpec widthSpec sizeFor: 0.
	totalHeight := measurementSpec heightSpec sizeFor: 0.
	availableHeight := measurementSpec heightSpec sizeFor: Float infinity.
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> tryFillAnchor: aFillAnchorState [
	<return: #Boolean>
	| initialElement initialElementPosition childViewport |
	
	aFillAnchorState availableHeight <= 0
		ifTrue: [ ^ false ].
		
	aFillAnchorState currentDataSourceIndex < 1
		ifTrue: [ ^ false ].

	aFillAnchorState currentDataSourceIndex > aFillAnchorState itemCount
		ifTrue: [ ^ false ].

	initialElement := fetcher fetchElementAt: aFillAnchorState currentDataSourceIndex.

	childViewport := nil.
	(measurementSpec widthSpec isUnspecified not
		and: [ measurementSpec heightSpec isUnspecified not ])
			ifTrue: [
				self flag: 'Handle various alignments'.
				childViewport := BlExtentMeasurementViewport fromTopEdge: (0@anchor offset negated extent: totalWidth @ totalHeight) ].
	
	initialElement measuredBounds position: 0@0.
	
	self
		measureChild: initialElement
		parentSpec: measurementSpec
		viewport: childViewport.
		
	initialElementPosition := aFillAnchorState elementAlignment
		translationOf: initialElement measuredBounds
		in: (0@0 extent: totalWidth @ totalHeight).

	initialElementPosition := initialElementPosition + aFillAnchorState currentPosition.

	initialElement measuredBounds position: 0 @ initialElementPosition y.
	
	aFillAnchorState measuredHeight += initialElement measuredBounds height.

	aFillAnchorState
		addFilledElementLast: initialElement
		dataSourceIndex: aFillAnchorState currentDataSourceIndex.

	^ true
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> tryFillNextSpaceDown: aFillDownState [
	"Attempts to fill space towards the bottom of the virtual list by inserting the next element from the data source. The method stops and returns false if there is not enough available height left, if all data items have been processed, or if the fill down position has reached the total height. Otherwise, it measures and adds the next element downward, adjusting available space and position accordingly, and returns true if the operation succeeds.
	
	This logic is specific for bottom-filling behaviors in virtualized lists."
	<return: #Boolean>
	| nextElementIndex nextElement childMeasurementSpec childViewport |

	aFillDownState availableHeight <= 0
		ifTrue: [ ^ false ].

	aFillDownState currentDataSourceIndex > aFillDownState itemCount
		ifTrue: [ ^ false ].
		
	measurementSpec viewport ifNotNil: [ :aViewport |
		aFillDownState currentPosition >= aViewport bounds bottom
			ifTrue: [ ^ false ] ].

	self flag: #TODO. "is this check needed"
	"aFillDownState currentPosition >= totalHeight
		ifTrue: [ ^ false ]."
		
	childViewport := nil.
	(measurementSpec widthSpec isUnspecified not
		and: [ measurementSpec heightSpec isUnspecified not ])
			ifTrue: [
				childViewport := BlExtentMeasurementViewport fromTopEdge: (0@aFillDownState currentPosition negated extent: totalWidth @ totalHeight) ].

	nextElementIndex := aFillDownState currentDataSourceIndex.
	nextElement := fetcher fetchElementAt: nextElementIndex.
	aFillDownState currentDataSourceIndex: nextElementIndex + 1.

	childMeasurementSpec := (self
		extentMeasurentSpecForChild: nextElement
		parentSpec: measurementSpec
		widthUsed: 0
		heightUsed: 0
		viewport: childViewport).
	
	nextElement measure: childMeasurementSpec.

	nextElement measuredBounds position: 0 @ aFillDownState currentPosition.

	aFillDownState availableHeight: aFillDownState availableHeight - nextElement measuredHeight.
	aFillDownState currentPosition: aFillDownState currentPosition + nextElement measuredHeight.
	
	aFillDownState measuredHeight += nextElement measuredBounds height.
	
	aFillDownState
		addFilledElementLast: nextElement
		dataSourceIndex: nextElementIndex.
	
	^ true
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> tryFillNextSpaceUp: aFillTopState [
	<return: #Boolean>
	| nextElement nextElementIndex childViewport |

	aFillTopState availableHeight <= 0
		ifTrue: [ ^ false ].

	aFillTopState currentDataSourceIndex < 1
		ifTrue: [ ^ false ].

	aFillTopState currentPosition <= 0.0
		ifTrue: [ ^ false ].
		
	measurementSpec viewport ifNotNil: [ :aViewport |
		aFillTopState currentPosition <= aViewport bounds top
			ifTrue: [ ^ false ] ].

	nextElementIndex := aFillTopState currentDataSourceIndex.
	nextElement := fetcher fetchElementAt: nextElementIndex.
	aFillTopState currentDataSourceIndex: nextElementIndex - 1.

	childViewport := nil.
	(measurementSpec widthSpec isUnspecified not
		and: [ measurementSpec heightSpec isUnspecified not ])
			ifTrue: [
				childViewport := BlExtentMeasurementViewport fromBottomEdge: (0@0 corner: totalWidth @ aFillTopState currentPosition) ].
	
	self
		measureChild: nextElement
		parentSpec: measurementSpec
		"viewport: childViewport".
	
	aFillTopState currentPosition: aFillTopState currentPosition - nextElement measuredHeight.
	
	nextElement measuredBounds position: 0 @ aFillTopState currentPosition.

	aFillTopState availableHeight: aFillTopState availableHeight - nextElement measuredHeight.
	
	aFillTopState measuredHeight += nextElement measuredBounds height.
	
	aFillTopState
		addFilledElementFirst: nextElement
		dataSourceIndex: nextElementIndex.
	
	^ true
]
