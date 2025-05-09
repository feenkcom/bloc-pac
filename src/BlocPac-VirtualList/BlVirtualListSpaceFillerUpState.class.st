Class {
	#name : #BlVirtualListSpaceFillerUpState,
	#superclass : #BlVirtualListSpaceFillerState,
	#instVars : [
		'currentBottomPosition',
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
	| state container frame realFrame firstOffset distanceMarker distanceLabel distance |
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

	frame
		addChild: (BrFrame new
				background: BrGlamorousColors errorBorderColor;
				hMatchParent;
				vExact: 3;
				relocate: 0 @ (startBottomOffset - 1)).


	state := BrFrame new
			hFitContent;
			clipChildren: false;
			vMatchParent.

	distance := (startBottomOffset - currentBottomPosition) abs.

	distanceMarker := BlElement new
			geometry: (BlNormalizedMultiPolylineGeometry
					polylines: {{0 @ 0.
								1 @ 0}.
							{0.5 @ 0.
								0.5 @ 1}.
							{0 @ 1.
								1 @ 1}});
			height: distance - 1;
			width: 10;
			outskirts: BlOutskirts centered;
			border: (BlBorder paint: BrGlamorousColors errorBorderColor width: 2).

	distanceLabel := BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			text: distance asString , 'pt'.

	state
		addChild: (BrHorizontalPane new
				alignCenter;
				vExact: distance;
				hFitContent;
				clipChildren: false;
				margin: (BlInsets top: currentBottomPosition left: 10);
				addChildren: {distanceMarker.
						distanceLabel}).

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

{ #category : #accessing }
BlVirtualListSpaceFillerUpState >> currentBottomPosition [
	^ currentBottomPosition
]

{ #category : #accessing }
BlVirtualListSpaceFillerUpState >> currentBottomPosition: anObject [
	currentBottomPosition := anObject
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
