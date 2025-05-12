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

{ #category : #accessing }
BlVirtualListSpaceFillerState >> filledElements [
	^ filledElements
]

{ #category : #accessing }
BlVirtualListSpaceFillerState >> filledElements: anObject [
	filledElements := anObject
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

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> isDown [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerState >> isUp [
	^ self subclassResponsibility
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
