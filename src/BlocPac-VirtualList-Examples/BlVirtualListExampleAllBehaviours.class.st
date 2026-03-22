Class {
	#name : #BlVirtualListExampleAllBehaviours,
	#superclass : #BlVirtualListDataSource,
	#instVars : [
		'classes'
	],
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #'as yet unclassified' }
BlVirtualListExampleAllBehaviours >> bindElement: anElement item: aClass index: anIndex [
	anElement text: aClass name
]

{ #category : #'instance creation' }
BlVirtualListExampleAllBehaviours >> createElement [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude
]

{ #category : #initialization }
BlVirtualListExampleAllBehaviours >> initialize [
	super initialize.
	
	classes := Smalltalk allClasses
]

{ #category : #accessing }
BlVirtualListExampleAllBehaviours >> itemAt: anIndex [
	^ classes at: anIndex
]

{ #category : #accessing }
BlVirtualListExampleAllBehaviours >> itemCount [
	^ classes size
]
