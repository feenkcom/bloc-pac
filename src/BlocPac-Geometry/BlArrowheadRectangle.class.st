Class {
	#name : #BlArrowheadRectangle,
	#superclass : #BlArrowheadElement,
	#instVars : [
		'scale'
	],
	#category : #'BlocPac-Geometry-Arrowheads'
}

{ #category : #accessing }
BlArrowheadRectangle >> initialize [
	super initialize.
	scale := 1.0
]

{ #category : #changes }
BlArrowheadRectangle >> onWidthChanged: aNumber [
	| aScaledWidth |
	aScaledWidth := self scale * aNumber.

	self size: aScaledWidth asPoint * 3.
	self border: (self border copyWithWidth: aNumber asFloat)
]

{ #category : #accessing }
BlArrowheadRectangle >> scale [
	^ scale
]

{ #category : #accessing }
BlArrowheadRectangle >> scale: aNumber [
	scale := aNumber.
	self geometryChanged
]
