Class {
	#name : #BlElementQueryGroupStepResult,
	#superclass : #BlElementQueryStepResult,
	#instVars : [
		'elements'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #adding }
BlElementQueryGroupStepResult >> addElement: aFoundElement [
	elements add: aFoundElement
]

{ #category : #accessing }
BlElementQueryGroupStepResult >> at: anIndex [
	^ elements at: anIndex
]

{ #category : #displaying }
BlElementQueryGroupStepResult >> displayString [
	^ '<1p> element<2?s:>' expandMacrosWith: self size with: self size ~= 1
]

{ #category : #enumerating }
BlElementQueryGroupStepResult >> do: aBlock deep: isDeep [
	isDeep
		ifTrue: [ elements do: [ :eachElement | eachElement allChildrenDepthFirstDo: aBlock ] ]
		ifFalse: [ elements do: [ :eachElement | eachElement childrenDo: aBlock ] ]
]

{ #category : #'gt-extensions' }
BlElementQueryGroupStepResult >> gtResultFor: aView [
	<gtView>
	self result ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Result';
		priority: 10;
		items: [ self result ]
]

{ #category : #initialization }
BlElementQueryGroupStepResult >> initialize [
	super initialize.
	
	elements := OrderedCollection new
]

{ #category : #accessing }
BlElementQueryGroupStepResult >> result [	
	^ elements
]

{ #category : #accessing }
BlElementQueryGroupStepResult >> size [
	^ elements size
]

{ #category : #testing }
BlElementQueryGroupStepResult >> wantsMore [
	^ true
]