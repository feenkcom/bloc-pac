Class {
	#name : #BlScrollbarPositionCalculator,
	#superclass : #Object,
	#instVars : [
		'sizes',
		'viewportSize'
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
						c horizontal matchParent ];
					layout: BlGridLayout vertical;
					padding: (BlInsets all: 20).
			itemContainer := BlElement new
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal matchParent ];
					layout: BlGridLayout horizontal.
			sizes
				withIndexDo: [ :each :i | 
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
					layout: BlGridLayout vertical;
					border: (BlBorder paint: Color gray).
			scrollbar := BlElement new
					constraintsDo: [ :c | 
						c vertical exact: 25.
						c horizontal exact: self thumbsize ];
					margin: (BlInsets top: 12.5);
					background: Color black.
			viewport addChild: scrollbar.
			container addChild: viewport.
			container ]
]

{ #category : #examples }
BlScrollbarPositionCalculator >> sizes: aSizeCollection [
	sizes := aSizeCollection
]

{ #category : #views }
BlScrollbarPositionCalculator >> thumbsize [
	^400
]

{ #category : #'as yet unclassified' }
BlScrollbarPositionCalculator >> viewportSize: aNumber [ 
	viewportSize := aNumber
]
