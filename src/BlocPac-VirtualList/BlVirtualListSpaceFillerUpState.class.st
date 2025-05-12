Class {
	#name : #BlVirtualListSpaceFillerUpState,
	#superclass : #BlVirtualListSpaceFillerState,
	#instVars : [
		'startBottomOffset'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerUpState >> asDownState [
	^ self shouldBeImplemented
]

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
					state };
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
				'Current position' -> currentPosition } ];
		column: 'Property' text: [ :each | each key ];
		column: 'Value' text: [ :each | each value ];
		send: [ :each | each value ]
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

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerUpState >> isDown [
	^ false
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerUpState >> isUp [
	^ true
]

{ #category : #'as yet unclassified' }
BlVirtualListSpaceFillerUpState >> shouldFillDown [
	^ self shouldBeImplemented
]

{ #category : #accessing }
BlVirtualListSpaceFillerUpState >> startBottomOffset [
	^ startBottomOffset
]

{ #category : #accessing }
BlVirtualListSpaceFillerUpState >> startBottomOffset: anObject [
	startBottomOffset := anObject
]
