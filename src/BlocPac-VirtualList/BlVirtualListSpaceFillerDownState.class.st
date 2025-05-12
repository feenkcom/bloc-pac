Class {
	#name : #BlVirtualListSpaceFillerDownState,
	#superclass : #BlVirtualListSpaceFillerState,
	#instVars : [
		'startTopOffset'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #views }
BlVirtualListSpaceFillerDownState >> asPreviewElement [
	| state container frame realFrame firstOffset markerPosition |
	frame := BlElement new
			size: totalWidth @ totalHeight;
			border: (BlBorder builder
					dashed;
					width: 1;
					paint: Color gray;
					build).

	firstOffset := filledElements
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :theElements | theElements first measuredPosition y ].

	realFrame := BrVerticalPane new
			fitContent;
			padding: (BlInsets top: firstOffset);
			clipChildren: false;
			border: (BlBorder builder
					dashed;
					width: 1;
					paint: Color gray;
					build).
					
	filledElements
		do: [ :eachChild | 
			realFrame
				addChild: (BlElement new
						background: Color veryVeryLightGray;
						border: Color veryLightGray;
						size: eachChild measuredExtent;
						relocate: eachChild measuredPosition;
						constraintsDo: [ :c | 
							c frame horizontal alignNone.
							c frame vertical alignNone ]) ].

	
	markerPosition := startTopOffset.
	
	frame
		addChild: (BrFrame new
				background: BrGlamorousColors primaryBorderColor;
				hMatchParent;
				vExact: 3;
				relocate: 0 @ (markerPosition - 1)).

	state := self
		gtNewDistanceMarker: availableHeight
		from: currentPosition
		color: BrGlamorousColors primaryBorderColor.

	container := BrHorizontalPane new
			fitContent;
			clipChildren: false;
			padding: (BlInsets top: (firstOffset min: 0) abs);
			addChildren: {BrFrame new
						fitContent;
						clipChildren: false;
						addChildren: {realFrame.
								frame}.
					state };
			yourself.
	^ container

]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerDownState >> asUpState [
	^ BlVirtualListSpaceFillerUpState new
		filledElements: filledElements;
		startDataSourceIndex: self startDataSourceIndex;
		startBottomOffset: totalHeight - self startTopOffset;
		currentDataSourceIndex: self startDataSourceIndex - 1;
		currentPosition: self startTopOffset;
		itemCount: itemCount;
		availableHeight: self availableSpaceAboveFirst;
		totalWidth: totalWidth;
		totalHeight: totalHeight;
		yourself
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerDownState >> availableSpaceAboveFirst [
	^ filledElements
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :theElements | theElements first measuredPosition y max: 0.0 ]
]

{ #category : #views }
BlVirtualListSpaceFillerDownState >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 3;
		items: [ {'Available height' -> availableHeight.
				'Start index' -> startDataSourceIndex.
				'Start top offset' -> startTopOffset.
				'Next index' -> currentDataSourceIndex.
				'Next position' -> currentPosition} ];
		column: 'Property' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]
]

{ #category : #views }
BlVirtualListSpaceFillerDownState >> gtPreviewFor: aView [
	<gtView>
	^ aView forward
		title: 'Preview';
		priority: 5;
		object: [ self asPreviewElement asCanvassableElement ];
		view: #gtLiveFor:;
		actionUpdateButton
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerDownState >> isDown [
	^ true
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerDownState >> isUp [
	^ false
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerDownState >> shouldFillUp [
	^ self availableSpaceAboveFirst > 0 and: [ self startDataSourceIndex > 1 ]
]

{ #category : #accessing }
BlVirtualListSpaceFillerDownState >> startTopOffset [
	^ startTopOffset
]

{ #category : #accessing }
BlVirtualListSpaceFillerDownState >> startTopOffset: anObject [
	startTopOffset := anObject
]
