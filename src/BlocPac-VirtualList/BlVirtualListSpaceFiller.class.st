Class {
	#name : #BlVirtualListSpaceFiller,
	#superclass : #Object,
	#traits : 'TBlWithLayoutMeasurement',
	#classTraits : 'TBlWithLayoutMeasurement classTrait',
	#instVars : [
		'fetcher',
		'viewport',
		'measurementSpec'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #views }
BlVirtualListSpaceFiller >> asPreviewElement [
	| state container steps |
	state := self createFillerDownState: self itemToFillFrom.

	steps := OrderedCollection new.

	[ steps add: state copy.
	self tryFillNextSpaceDown: state ] whileTrue.


	container := BrHorizontalFlow new
			vFitContent;
			hMatchParent.

	steps
		do: [ :each | 
			container
				addChild: (each asPreviewElement asScalableElement
						clipChildren: false;
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
		currentDataSourceIndex: anItemToFillFrom dataSourceIndex;
		currentTopPosition: anItemToFillFrom offset;
		itemCount: fetcher dataSource itemCount;
		availableHeight: totalHeight + (anItemToFillFrom offset min: 0) abs;
		totalWidth: totalWidth;
		totalHeight: totalHeight;
		yourself
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpace [
	self itemToFillFrom
		ifTop: [ :anItemToFillFrom | 
			self fillSpaceDown: (self createFillerDownState: anItemToFillFrom) ]
		ifBottom: [ :anItemToFillFrom |  ]
]

{ #category : #'private - measurement' }
BlVirtualListSpaceFiller >> fillSpaceDown: aFillerDownState [
	 [ self tryFillNextSpaceDown: aFillerDownState ] whileTrue
]

{ #category : #accessing }
BlVirtualListSpaceFiller >> filledElements [
	^ filledElements
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
