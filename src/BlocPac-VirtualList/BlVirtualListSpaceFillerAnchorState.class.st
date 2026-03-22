Class {
	#name : #BlVirtualListSpaceFillerAnchorState,
	#superclass : #BlVirtualListSpaceFillerState,
	#instVars : [
		'elementAlignment'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #converting }
BlVirtualListSpaceFillerAnchorState >> asFillDownState [
	| availableSpaceBelowLast anchorItemBottom |
	
	availableSpaceBelowLast := self availableSpaceBelowLast.
	anchorItemBottom := filledItems last bounds bottom.

	^ BlVirtualListSpaceFillerDownState new
		filledElements: filledItems;
		startDataSourceIndex: self startDataSourceIndex;
		startTopOffset: anchorItemBottom;
		currentDataSourceIndex: self startDataSourceIndex + 1;
		currentPosition: anchorItemBottom;
		itemCount: itemCount;
		availableHeight: availableSpaceBelowLast;
		totalWidth: totalWidth;
		totalHeight: totalHeight;
		measuredHeight: measuredHeight;
		yourself
]

{ #category : #converting }
BlVirtualListSpaceFillerAnchorState >> asFillUpState [
	| availableSpaceAboveFirst |
	
	availableSpaceAboveFirst := self availableSpaceAboveFirst.
	
	^ BlVirtualListSpaceFillerUpState new
		filledElements: filledItems;
		startDataSourceIndex: self startDataSourceIndex;
		startBottomOffset: totalHeight - availableSpaceAboveFirst;
		currentDataSourceIndex: self startDataSourceIndex - 1;
		currentPosition: availableSpaceAboveFirst;
		itemCount: itemCount;
		availableHeight: availableSpaceAboveFirst;
		totalWidth: totalWidth;
		totalHeight: totalHeight;
		measuredHeight: measuredHeight;
		yourself
]

{ #category : #converting }
BlVirtualListSpaceFillerAnchorState >> asPreviewElement [
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
			ifNotEmpty: [ :theElements | theElements first bounds origin y ].

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
						background: (Color gray alpha: 0.25);
						border: Color veryLightGray;
						size: eachChild bounds extent;
						relocate: eachChild bounds origin;
						constraintsDo: [ :c | 
							c frame horizontal alignNone.
							c frame vertical alignNone ];
						addChild: (BrLabel new
								aptitude: (BrGlamorousLabelAptitude new foreground: Color darkGray);
								text: eachChild dataSourceIndex;
								constraintsDo: [ :c | 
									c frame horizontal alignCenter.
									c frame vertical alignCenter ])) ].


	markerPosition := (elementAlignment translationOf: (0@0 extent: 0@0) in: (0@0 extent: totalWidth @ totalHeight)) y.

	frame
		addChild: (BrFrame new
				background: BrGlamorousColors successBorderColor;
				hMatchParent;
				vExact: 3;
				relocate: 0 @ (markerPosition - 1)).
				
	measurementViewport ifNotNil: [ :aViewportRectangle |
		realFrame addChild: (BlElement new
			constraintsDo: [ :c | c ignoreByLayout ];
			relocate: aViewportRectangle bounds origin;
			size: aViewportRectangle bounds extent;
			border: (BlBorder builder
					dashed;
					width: 1;
					paint: Color red;
					build)).
	
	].

	state := self
			gtNewDistanceMarker: availableHeight
			from: currentPosition
			color: BrGlamorousColors successBorderColor.

	container := BrHorizontalPane new
			fitContent;
			clipChildren: false;
			padding: (BlInsets top: (firstOffset min: 0) abs);
			addChildren: {BrFrame new
						fitContent;
						clipChildren: false;
						addChildren: {frame . realFrame.
								}.
					state};
			yourself.
	^ container
]

{ #category : #accessing }
BlVirtualListSpaceFillerAnchorState >> elementAlignment [
	^ elementAlignment
]

{ #category : #accessing }
BlVirtualListSpaceFillerAnchorState >> elementAlignment: anObject [
	elementAlignment := anObject
]

{ #category : #views }
BlVirtualListSpaceFillerAnchorState >> gtPreviewFor: aView [
	<gtView>
	^ aView forward
		title: 'Preview';
		priority: 5;
		object: [ self asPreviewElement asCanvassableElement ];
		view: #gtLiveFor:;
		actionUpdateButton
]
