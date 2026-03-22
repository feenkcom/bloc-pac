Class {
	#name : #BlVirtualListExampleAllBehavioursAndMethods,
	#superclass : #BlVirtualListDataSource,
	#instVars : [
		'classes'
	],
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #'as yet unclassified' }
BlVirtualListExampleAllBehavioursAndMethods >> bindElement: anElement item: aClass index: anIndex [
	anElement text: aClass name
]

{ #category : #'instance creation' }
BlVirtualListExampleAllBehavioursAndMethods >> createElement [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude
]

{ #category : #initialization }
BlVirtualListExampleAllBehavioursAndMethods >> initialize [
	super initialize.
	
	classes := Smalltalk allClasses
]

{ #category : #accessing }
BlVirtualListExampleAllBehavioursAndMethods >> itemAt: anIndex [
	^ classes at: anIndex
]

{ #category : #accessing }
BlVirtualListExampleAllBehavioursAndMethods >> itemCount [
	^ classes size
]
