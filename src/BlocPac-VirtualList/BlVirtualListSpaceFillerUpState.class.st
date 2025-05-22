Class {
	#name : #BlVirtualListSpaceFillerUpState,
	#superclass : #BlVirtualListSpaceFillerState,
	#instVars : [
		'startBottomOffset'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerUpState >> asPreviewElement [
	| state container frame realFrame firstOffset markerPosition |
	frame := BlElement new
			size: totalWidth @ totalHeight;
			border: (BlBorder builder
					dashed;
					width: 1;
					paint: Color gray;
					build).
	firstOffset := filledItems
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
	filledItems
		withIndexDo: [ :eachChild :anIndex | 
			realFrame
				addChild: (BrFrame new
						background: Color veryVeryLightGray;
						border: Color veryLightGray;
						size: eachChild measuredExtent;
						relocate: eachChild measuredPosition;
						constraintsDo: [ :c | 
							c frame horizontal alignNone.
							c frame vertical alignNone ];
						addChild: (BrLabel new
								aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
								text: anIndex + self currentDataSourceIndex;
								constraintsDo: [ :c | 
									c frame horizontal alignCenter.
									c frame vertical alignCenter ])) ].
	markerPosition := totalHeight - startBottomOffset.
	frame
		addChild: (BrFrame new
				background: BrGlamorousColors errorBorderColor;
				hMatchParent;
				vExact: 3;
				relocate: 0 @ (markerPosition - 1)).

	state := self
			gtNewDistanceMarker: availableHeight
			from: 0
			color: BrGlamorousColors errorBorderColor.

	container := BrHorizontalPane new
			fitContent;
			clipChildren: false;
			padding: (BlInsets top: (firstOffset min: 0) abs);
			addChildren: {BrFrame new
						fitContent;
						clipChildren: false;
						addChildren: {realFrame.
								frame}.
					state};
			yourself.
	^ container
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerUpState >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 3;
		items: [ {'Available height' -> availableHeight.
				'Start index' -> startDataSourceIndex.
				'Start bottom offset' -> startBottomOffset.
				'Current index' -> currentDataSourceIndex.
				'Current position' -> currentPosition.
				'Viewport' -> self viewport } ];
		column: 'Property' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ];
		actionUpdateButton
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerUpState >> gtPreviewFor: aView [
	<gtView>
	^ aView forward
		title: 'Preview';
		priority: 5;
		object: [ self asPreviewElement asCanvassableElement ];
		view: #gtLiveFor:;
		actionUpdateButton
]

{ #category : #accessing }
BlVirtualListSpaceFillerUpState >> startBottomOffset [
	^ startBottomOffset
]

{ #category : #accessing }
BlVirtualListSpaceFillerUpState >> startBottomOffset: anObject [
	startBottomOffset := anObject
]
