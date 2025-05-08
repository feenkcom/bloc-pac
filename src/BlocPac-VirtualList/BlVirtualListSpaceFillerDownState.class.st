Class {
	#name : #BlVirtualListSpaceFillerDownState,
	#superclass : #BlVirtualListSpaceFillerState,
	#instVars : [
		'currentTopPosition'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #views }
BlVirtualListSpaceFillerDownState >> asPreviewElement [
	| state container frame realFrame firstOffset |
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
				background: BrGlamorousColors primaryBorderColor;
				hMatchParent;
				vExact: 3;
				relocate: 0 @ (currentTopPosition - 1)).


	state := BrFrame new
			hFitContent;
			clipChildren: false;
			vMatchParent.

	state
		addChild: (BlElement new
				geometry: (BlNormalizedMultiPolylineGeometry
						polylines: {{0 @ 0.
									1 @ 0}.
								{0.5 @ 0.
									0.5 @ 1}.
								{0 @ 1.
									1 @ 1}});
				height: currentTopPosition - 1;
				width: 10;
				margin: (BlInsets top: 1 left: 10);
				outskirts: BlOutskirts centered;
				border: (BlBorder paint: BrGlamorousColors primaryBorderColor width: 2)).

	state
		addChild: (BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: currentTopPosition asString , 'pt';
				margin: (BlInsets left: 20);
				constraintsDo: [ :c | c frame vertical alignCenterAt: currentTopPosition / 2.0 / totalHeight ]).

	container := BrHorizontalPane new
			fitContent;
			clipChildren: false;
			addChildren: {
				BrFrame new
					fitContent;
					clipChildren: false;
					addChildren: { realFrame. frame }.
			
			
					state};
			yourself.

	^ container
]

{ #category : #accessing }
BlVirtualListSpaceFillerDownState >> currentTopPosition [
	^ currentTopPosition
]

{ #category : #accessing }
BlVirtualListSpaceFillerDownState >> currentTopPosition: anObject [
	currentTopPosition := anObject
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
