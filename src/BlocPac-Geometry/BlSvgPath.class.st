"
I am the ${class:BlElementVectorGeometry}$ used to represent a SVG Path, which allows to make complex drawings.

A SVG Path is obtained through successives commands, which each symbolizes a movement of the virtual pen drawing the path.
My instance variable'pathData' stores the list of commands used to obtain my final drawing.

To instanciate myself I use the BlSvgPathConverter class, which will allow me to set my 'pathData' instance variable.
To calculate my extent I use the BlSvgPathExtentResolver class, which calculates my extent when I set my 'pathData' instance variable.

Instance creation examples:
	- BlSvgPath new svg: 'M100,200 C100,100 250,100 250,200 S400,300 400,200' viewbox: (0@0 extent: 4000@400) 
"
Class {
	#name : #BlSvgPath,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'position',
		'segments',
		'viewbox'
	],
	#category : #'BlocPac-Geometry-SVG'
}

{ #category : #'instance creation' }
BlSvgPath class >> build: aBlock [
	^ self new build: aBlock
]

{ #category : #initialization }
BlSvgPath >> build: aBlock viewbox: aRectangle [
	| aPathbuilder |
	aPathbuilder := BlSvgPathBuilder new.
	aBlock value: aPathbuilder.
	segments := aPathbuilder segments.
	viewbox := aRectangle
]

{ #category : #accessing }
BlSvgPath >> buildPathOnSpartaCanvas: aCanvas [
	| pathBuilder|

	pathBuilder := aCanvas path.
	segments do: [ :each |  each executeOn: pathBuilder ].
	^ pathBuilder finish
]

{ #category : #accessing }
BlSvgPath >> gtSegmentsFor: aView [
	<gtView>
	^ aView list
		title: 'Segments';
		items: [segments]
]

{ #category : #initialization }
BlSvgPath >> initialize [
	super initialize.
	
	segments := #().
	viewbox := 0.0@0.0 extent: 50.0@50.0
]

{ #category : #accessing }
BlSvgPath >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #initialization }
BlSvgPath >> svg: anSvgString viewbox: aRectangle [
	segments := (BlSvgPathBuilder fromStream: anSvgString readStream) segments.
	viewbox := aRectangle asBlocFloatRectangle
]
