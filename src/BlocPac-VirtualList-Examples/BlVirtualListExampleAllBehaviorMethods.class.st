Class {
	#name : #BlVirtualListExampleAllBehaviorMethods,
	#superclass : #BlVirtualListDataSource,
	#instVars : [
		'methods',
		'behavior'
	],
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #accessing }
BlVirtualListExampleAllBehaviorMethods >> behavior [
	^ behavior
]

{ #category : #accessing }
BlVirtualListExampleAllBehaviorMethods >> behavior: anObject [
	behavior := anObject.
	methods := behavior methods
]

{ #category : #'as yet unclassified' }
BlVirtualListExampleAllBehaviorMethods >> bindElement: anElement item: aMethod index: anIndex [
	anElement text: aMethod printString
]

{ #category : #'instance creation' }
BlVirtualListExampleAllBehaviorMethods >> createElement [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude
]

{ #category : #initialization }
BlVirtualListExampleAllBehaviorMethods >> initialize [
	super initialize.
	
	classes := Smalltalk allClasses
]

{ #category : #accessing }
BlVirtualListExampleAllBehaviorMethods >> itemAt: anIndex [
	^ classes at: anIndex
]

{ #category : #accessing }
BlVirtualListExampleAllBehaviorMethods >> itemCount [
	^ classes size
]
