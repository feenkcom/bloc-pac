Class {
	#name : #BlScrollbarPositionCalculator,
	#superclass : #Object,
	#instVars : [
		'sizes',
		'viewportSize',
		'scrollOffset',
		'topIndex'
	],
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #examples }
BlScrollbarPositionCalculator class >> forSizes: aSizeCollection [
	^self new sizes: aSizeCollection
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
				to: sizes size
				do: [ :i | 
					| each |
					each := (sizes at: i) - (sizes at: i - 1).
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
					relocate: (20 + (sizes at: topIndex) - scrollOffset) @ 80;
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
	viewportSize := 1.
	sizes := #(0)
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
	"sizes stores the cumulative size at each index with a 0 in the first position and the total size in the last"
	
	sizes := self rollup: aSizeCollection
]

{ #category : #computing }
BlScrollbarPositionCalculator >> thumbOffset [
	^ ((sizes at: topIndex) - scrollOffset) / self totalSize * viewportSize
]

{ #category : #'as yet unclassified' }
BlScrollbarPositionCalculator >> thumbSize [
	^ viewportSize / self totalSize * viewportSize
]

{ #category : #'as yet unclassified' }
BlScrollbarPositionCalculator >> topIndex: anInteger [ 
	topIndex := anInteger
]

{ #category : #computing }
BlScrollbarPositionCalculator >> totalSize [
	^ sizes last
]

{ #category : #'as yet unclassified' }
BlScrollbarPositionCalculator >> viewportSize: aNumber [ 
	viewportSize := aNumber
]
