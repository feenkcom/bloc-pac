Class {
	#name : #BlCommonParentDetectorExamples,
	#superclass : #Object,
	#instVars : [
		'grandParent',
		'commonParent',
		'parent',
		'childB',
		'childA'
	],
	#category : #'BlocPac-CommonParent-Examples'
}

{ #category : #private }
BlCommonParentDetectorExamples >> childA [
	^ childA ifNil: [ childA := BlElement new
		background: Color paleRed;
		size: 35@35;
		id: #childA ]
]

{ #category : #private }
BlCommonParentDetectorExamples >> childB [
	^ childB ifNil: [ childB := BlElement new
		background: Color paleBlue;
		size: 65@45;
		id: #childB ]
]

{ #category : #private }
BlCommonParentDetectorExamples >> commonParent [
	^ commonParent ifNil: [ commonParent := BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 10);
		padding: (BlInsets top: 10 bottom: 10);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		background: (Color gray alpha: 0.15);
		id: #commonParent ]
]

{ #category : #examples }
BlCommonParentDetectorExamples >> defaultDetector [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := BlCommonParentDetector new.

	self assert: detector elements equals: {}.
	self assert: detector provisionalCommonParent equals: nil.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> detectorOnCommonParentInGrandParent [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnTwoChildrenWithTwoLazyParentsBA.

	self grandParent addChild: self commonParent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self commonParent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> detectorOnTwoChildrenWithOneLazyParentA [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnTwoChildrenWithoutParent.

	self parent addChild: self childA.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self parent.
	self assert: detector elementsWithoutCommonParent equals: {self childB} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> detectorOnTwoChildrenWithOneLazyParentB [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnTwoChildrenWithoutParent.

	self commonParent addChild: self childB.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {self childA} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> detectorOnTwoChildrenWithOneParentA [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	self parent addChild: self childA.

	detector := self defaultDetector.
	detector
		setElements: {self childA.
				self childB}.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self parent.
	self assert: detector elementsWithoutCommonParent equals: {self childB} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> detectorOnTwoChildrenWithOneParentB [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	self commonParent addChild: self childB.

	detector := self defaultDetector.
	detector
		setElements: {self childA.
				self childB}.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {self childA} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> detectorOnTwoChildrenWithTwoLazyParentsAB [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnTwoChildrenWithOneLazyParentA.

	self commonParent addChild: self childB.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self parent.
	self assert: detector elementsWithoutCommonParent equals: {self childB} asSet.
	self assert: detector commonParent equals: nil.

	self commonParent addChild: self parent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self commonParent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> detectorOnTwoChildrenWithTwoLazyParentsABInverted [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnTwoChildrenWithOneLazyParentA.

	self commonParent addChild: self parent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self parent.
	self assert: detector elementsWithoutCommonParent equals: {self childB} asSet.
	self assert: detector commonParent equals: nil.

	self commonParent addChild: self childB.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self commonParent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> detectorOnTwoChildrenWithTwoLazyParentsBA [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnTwoChildrenWithOneLazyParentB.

	self parent addChild: self childA.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {self childA} asSet.
	self assert: detector commonParent equals: nil.

	self commonParent addChild: self parent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self commonParent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> detectorOnTwoChildrenWithTwoLazyParentsBAInverted [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnTwoChildrenWithOneLazyParentB.

	self commonParent addChild: self parent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {self childA} asSet.
	self assert: detector commonParent equals: nil.

	self parent addChild: self childA.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self commonParent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> detectorOnTwoChildrenWithoutParent [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self defaultDetector.
	detector
		setElements: {self childA.
				self childB}.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: nil.
	self
		assert: detector elementsWithoutCommonParent
		equals: {self childA.
				self childB} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #private }
BlCommonParentDetectorExamples >> grandParent [
	^ grandParent ifNil: [ grandParent := BlElement new
		id: #grandParent;
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ] ]
]

{ #category : #private }
BlCommonParentDetectorExamples >> parent [
	^ parent ifNil: [ parent := BlElement new
		padding: (BlInsets all: 10);
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		background: (Color gray alpha: 0.15);
		id: #parent ]
]

{ #category : #examples }
BlCommonParentDetectorExamples >> registerChildA [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self unregisterChildAChildB.
	detector addElement: self childA.

	self assert: detector elements equals: {self childA}.
	self assert: detector provisionalCommonParent equals: self parent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self parent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> registerChildAChildB [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self registerChildA.
	detector addElement: self childB.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self commonParent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> registerChildB [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self unregisterChildAChildB.
	detector addElement: self childB.

	self assert: detector elements equals: {self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self commonParent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> registerChildBChildA [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self registerChildB.
	detector addElement: self childA.

	self
		assert: detector elements
		equals: {self childB.
				self childA}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self commonParent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> removeChildA [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnCommonParentInGrandParent.

	self childA removeFromParent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {self childA} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> removeChildAChildB [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self removeChildA.

	self childB removeFromParent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: nil.
	self
		assert: detector elementsWithoutCommonParent
		equals: {self childA.
				self childB} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> removeChildB [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnCommonParentInGrandParent.

	self childB removeFromParent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self parent.
	self assert: detector elementsWithoutCommonParent equals: {self childB} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> removeChildBChildA [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self removeChildB.

	self childA removeFromParent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: nil.
	self
		assert: detector elementsWithoutCommonParent
		equals: {self childA.
				self childB} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> removeCommonParent [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnCommonParentInGrandParent.

	self grandParent removeChild: self commonParent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self commonParent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> removeParent [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnCommonParentInGrandParent.

	self parent removeFromParent.

	self
		assert: detector elements
		equals: {self childA.
				self childB}.
	self assert: detector provisionalCommonParent equals: self parent.
	self assert: detector elementsWithoutCommonParent equals: {self childB} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> unregisterChildA [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnCommonParentInGrandParent.
	detector removeElement: self childA.

	self assert: detector elements equals: {self childB}.
	self assert: detector provisionalCommonParent equals: self commonParent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self commonParent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> unregisterChildAChildB [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self unregisterChildA.
	detector removeElement: self childB.

	self assert: detector elements equals: {}.
	self assert: detector provisionalCommonParent equals: nil.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> unregisterChildB [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self detectorOnCommonParentInGrandParent.
	detector removeElement: self childB.

	self assert: detector elements equals: {self childA}.
	self assert: detector provisionalCommonParent equals: self parent.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: self parent.

	^ detector
]

{ #category : #examples }
BlCommonParentDetectorExamples >> unregisterChildBChildA [
	<gtExample>
	<return: #BlCommonParentDetector>
	| detector |
	detector := self unregisterChildB.
	detector removeElement: self childA.

	self assert: detector elements equals: {}.
	self assert: detector provisionalCommonParent equals: nil.
	self assert: detector elementsWithoutCommonParent equals: {} asSet.
	self assert: detector commonParent equals: nil.

	^ detector
]
