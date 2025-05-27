Class {
	#name : #BlScrollbarPositionCalculator,
	#superclass : #Object,
	#instVars : [
		'sizes',
		'viewportSize',
		'scrollOffset',
		'topIndex',
		'minimumThumb'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #examples }
BlScrollbarPositionCalculator class >> forSizes: aSizeCollection [
	^self new sizes: aSizeCollection
]

{ #category : #'as yet unclassified' }
BlScrollbarPositionCalculator >> calculatedThumbSize [
	^ viewportSize / sizes totalSize * viewportSize
]

{ #category : #views }
BlScrollbarPositionCalculator >> gtViewFor: aView [
	<gtView>
	^ aView explicit
		title: 'View';
		stencil: [ | itemContainer container viewport scrollbar |
			container := BlElement new
					constraintsDo: [ :c | 
						c vertical matchParent.
						c horizontal matchParent ].
			itemContainer := BlElement new
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal matchParent ];
					relocate: 20 @ 20;
					layout: BlGridLayout horizontal.
			2
				to: sizes count
				do: [ :i | 
					| each |
					each := (sizes sizeUpTo: i) - (sizes sizeUpTo: i - 1).
					itemContainer
						addChild: (BlElement new
								constraintsDo: [ :c | 
									c vertical exact: 50.
									c horizontal exact: each ];
								border: (BlBorder paint: Color gray)) ].
			container addChild: itemContainer.
			viewport := BlElement new
					constraintsDo: [ :c | 
						c vertical exact: 50.
						c horizontal exact: viewportSize ];
					relocate: (20 + (sizes sizeUpTo: topIndex) - scrollOffset) @ 80;
					layout: BlBasicLayout new;
					border: (BlBorder paint: Color gray).
			scrollbar := BlElement new
					constraintsDo: [ :c | 
						c vertical exact: 25.
						c horizontal exact: self thumbSize ];
					relocate: self thumbOffset @ 12.5;
					background: Color black.
			viewport addChild: scrollbar.
			container addChild: viewport.
			container ]
]

{ #category : #initialization }
BlScrollbarPositionCalculator >> initialize [
	super initialize.
	topIndex := 1.
	scrollOffset := 0.
	minimumThumb := 0.
	viewportSize := 1.
	sizes := BlVirtualListSizeCollection new.
]

{ #category : #'as yet unclassified' }
BlScrollbarPositionCalculator >> minimumThumb: aNumber [ 
	minimumThumb := aNumber
]

{ #category : #private }
BlScrollbarPositionCalculator >> rollup: aSizeCollection [
	| total |
	total := 0.
	^ #(0) , aSizeCollection collect: [ :each | total := total + each ]
]

{ #category : #acccessing }
BlScrollbarPositionCalculator >> scrollOffset: aNumber [ 
	scrollOffset := aNumber
]

{ #category : #accesing }
BlScrollbarPositionCalculator >> sizes: aSizeCollection [
	sizes := BlVirtualListSizeCollection fromSizes: aSizeCollection
]

{ #category : #'as yet unclassified' }
BlScrollbarPositionCalculator >> thumbDifferenceWithCalculated [
	^ (minimumThumb - self calculatedThumbSize) max: 0
]

{ #category : #computing }
BlScrollbarPositionCalculator >> thumbOffset [
	^ ((sizes sizeUpTo: topIndex) - scrollOffset) / sizes totalSize * (viewportSize - self thumbDifferenceWithCalculated)
]

{ #category : #'as yet unclassified' }
BlScrollbarPositionCalculator >> thumbSize [
	^ self calculatedThumbSize max: minimumThumb
]

{ #category : #'as yet unclassified' }
BlScrollbarPositionCalculator >> topIndex: anInteger [ 
	topIndex := anInteger
]

{ #category : #accessing }
BlScrollbarPositionCalculator >> viewportSize [
	^ viewportSize
]

{ #category : #'as yet unclassified' }
BlScrollbarPositionCalculator >> viewportSize: aNumber [ 
	viewportSize := aNumber
]
