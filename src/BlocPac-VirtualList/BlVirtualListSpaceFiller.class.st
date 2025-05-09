Class {
	#name : #BlVirtualListSpaceFiller,
	#superclass : #Object,
	#traits : 'TBlWithLayoutMeasurement',
	#classTraits : 'TBlWithLayoutMeasurement classTrait',
	#instVars : [
		'fetcher',
		'viewport',
		'measurementSpec',
		'totalHeight',
		'totalWidth'
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

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> createFillerDownState: anItemToFillFrom [
	^ BlVirtualListSpaceFillerDownState new
		startDataSourceIndex: anItemToFillFrom dataSourceIndex;
		startTopOffset: anItemToFillFrom offset;
		currentDataSourceIndex: anItemToFillFrom dataSourceIndex;
		currentTopPosition: anItemToFillFrom offset;
		itemCount: fetcher dataSource itemCount;
		availableHeight: totalHeight + (anItemToFillFrom offset min: 0) abs;
		totalWidth: totalWidth;
		totalHeight: totalHeight;
		yourself
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> createFillerUpState: anItemToFillFrom [
	^ BlVirtualListSpaceFillerUpState new
		startDataSourceIndex: anItemToFillFrom dataSourceIndex;
		startBottomOffset: anItemToFillFrom offset;
		currentDataSourceIndex: anItemToFillFrom dataSourceIndex;
		currentBottomPosition: totalHeight - anItemToFillFrom offset;
		itemCount: fetcher dataSource itemCount;
		availableHeight: totalHeight + (anItemToFillFrom offset min: 0) abs;
		totalWidth: totalWidth;
		totalHeight: totalHeight;
		yourself
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpace [
	^ self fillSpaceAndDo: [ :eachState | ]
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpaceAndDo: eachStateBlock [
	self itemToFillFrom
		ifTop: [ :itemToFillFromTop |
			| fillerState |
			fillerState := self createFillerDownState: itemToFillFromTop.
			self fillSpaceDown: fillerState andEachStepDo: eachStateBlock.
			fillerState shouldFillUp
				ifTrue: [ self fillSpaceUp: fillerState asUpState andEachStepDo: eachStateBlock ] ]
		ifBottom: [ :itemToFillFromBottom |
			| fillerState |
			fillerState := self createFillerUpState: itemToFillFromBottom.
			self fillSpaceUp: fillerState andEachStepDo: eachStateBlock.
			fillerState shouldFillDown
				ifTrue: [ self fillSpaceDown: fillerState asDownState andEachStepDo: eachStateBlock ] ]
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpaceDown: aFillerDownState andEachStepDo: aBlock [
	 [ aBlock cull: aFillerDownState. self tryFillNextSpaceDown: aFillerDownState ] whileTrue
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpaceUp: aFillerUpState andEachStepDo: aBlock [
	 [ aBlock cull: aFillerUpState. self tryFillNextSpaceUp: aFillerUpState ] whileTrue
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

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFiller >> itemToFillFrom [
	^ viewport itemToFillFrom
]

{ #category : #initialization }
BlVirtualListSpaceFiller >> setFetcher: aFetcher viewport: aViewport measurementSpec: aMeasurementSpec [
	fetcher := aFetcher.
	viewport := aViewport.
	measurementSpec := aMeasurementSpec.
	totalWidth := measurementSpec widthSpec sizeFor: Float infinity.
	totalHeight := measurementSpec heightSpec sizeFor: Float infinity.
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> tryFillNextSpaceDown: aFillDownState [
	"Attempts to fill space towards the bottom of the virtual list by inserting the next element from the data source. The method stops and returns false if there is not enough available height left, if all data items have been processed, or if the fill down position has reached the total height. Otherwise, it measures and adds the next element downward, adjusting available space and position accordingly, and returns true if the operation succeeds.
	
	This logic is specific for bottom-filling behaviors in virtualized lists."
	<return: #Boolean>
	| nextElement |

	aFillDownState availableHeight <= 0
		ifTrue: [ ^ false ].

	aFillDownState currentDataSourceIndex > aFillDownState itemCount
		ifTrue: [ ^ false ].

	aFillDownState currentTopPosition >= totalHeight
		ifTrue: [ ^ false ].

	nextElement := fetcher fetchElementAt: aFillDownState currentDataSourceIndex.
	aFillDownState currentDataSourceIndex: aFillDownState currentDataSourceIndex + 1.

	self
		measureChild: nextElement
		parentSpec: measurementSpec.

	nextElement measuredBounds position: 0 @ aFillDownState currentTopPosition.

	aFillDownState availableHeight: aFillDownState availableHeight - nextElement measuredHeight.
	aFillDownState currentTopPosition: aFillDownState currentTopPosition + nextElement measuredHeight.
	aFillDownState filledElements addLast: nextElement.
	
	^ true
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> tryFillNextSpaceUp: aFillTopState [
	<return: #Boolean>
	| nextElement |

	aFillTopState availableHeight <= 0
		ifTrue: [ ^ false ].

	aFillTopState currentDataSourceIndex < 1
		ifTrue: [ ^ false ].

	aFillTopState currentBottomPosition <= 0.0
		ifTrue: [ ^ false ].

	nextElement := fetcher fetchElementAt: aFillTopState currentDataSourceIndex.
	aFillTopState currentDataSourceIndex: aFillTopState currentDataSourceIndex - 1.

	self
		measureChild: nextElement
		parentSpec: measurementSpec.
	
	aFillTopState currentBottomPosition: aFillTopState currentBottomPosition - nextElement measuredHeight.
	
	nextElement measuredBounds position: 0 @ aFillTopState currentBottomPosition.

	aFillTopState availableHeight: aFillTopState availableHeight - nextElement measuredHeight.
	
	aFillTopState filledElements addFirst: nextElement.
	
	^ true
]
