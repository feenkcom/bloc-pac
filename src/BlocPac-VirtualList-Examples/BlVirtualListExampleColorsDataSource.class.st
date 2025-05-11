Class {
	#name : #BlVirtualListExampleColorsDataSource,
	#superclass : #BlVirtualListDataSource,
	#instVars : [
		'colors'
	],
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #'as yet unclassified' }
BlVirtualListExampleColorsDataSource >> bindElement: anElement item: aColor index: anIndex [
	anElement background: aColor
]

{ #category : #initialization }
BlVirtualListExampleColorsDataSource >> blueAt: anIndex [
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	radians < (Float pi / 2.0)
		ifTrue: [ ^ 0 ].
	^ (radians - (Float pi / 2.0)) sin
]

{ #category : #initialization }
BlVirtualListExampleColorsDataSource >> colorAt: anIndex [
	| normalizedIndex |
	"0.0 <= anIndex <= 1.0"
	
	normalizedIndex := anIndex.
	"Because of float errors"
	normalizedIndex > 1 ifTrue: [ normalizedIndex := 1 ].
	normalizedIndex < 0 ifTrue: [ normalizedIndex := 0 ].
	
	^ Color
		r: (self redAt: normalizedIndex)
		g: (self greenAt: normalizedIndex)
		b: (self blueAt: normalizedIndex)
]

{ #category : #'instance creation' }
BlVirtualListExampleColorsDataSource >> createElement [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 50 ]
]

{ #category : #initialization }
BlVirtualListExampleColorsDataSource >> greenAt: anIndex [
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	radians > Float pi
		ifTrue: [ ^ 0 ].
	^ radians sin
]

{ #category : #initialization }
BlVirtualListExampleColorsDataSource >> initialize [
	super initialize.
	
	"colors := (Color registeredColorNames asOrderedCollection collect: [ :aName | Color named: aName asSymbol ])".
	colors := ((0 to: 1 by: 0.01) collect: [ :anIndex | self colorAt: anIndex ]) asOrderedCollection
]

{ #category : #accessing }
BlVirtualListExampleColorsDataSource >> itemAt: anIndex [
	^ colors at: anIndex
]

{ #category : #accessing }
BlVirtualListExampleColorsDataSource >> itemCount [
	^ colors size
]

{ #category : #initialization }
BlVirtualListExampleColorsDataSource >> radiansAt: anIndex [
	"0.0 <= anIndex <= 1.0"
	self assert: [ anIndex between: 0.0 and: 1.0 ].
	
	^ anIndex * (Float pi * 3) / 2.0
]

{ #category : #initialization }
BlVirtualListExampleColorsDataSource >> redAt: anIndex [
	| radians |
	"0.0 <= anIndex <= 1.0"
	
	radians := self radiansAt: anIndex.
	(radians between: Float pi / 2.0 and: Float pi) 
		ifTrue: [ ^ 0 ].

	radians < (Float pi/ 2.0)
		ifTrue: [ ^ (radians + (Float pi / 2)) sin ].

	^ (radians + Float pi) sin
]
