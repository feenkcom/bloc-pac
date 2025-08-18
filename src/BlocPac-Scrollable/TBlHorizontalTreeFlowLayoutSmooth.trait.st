Trait {
	#name : #TBlHorizontalTreeFlowLayoutSmooth,
	#traits : 'TBlMiniHorizontalScrollable',
	#classTraits : 'TBlMiniHorizontalScrollable classTrait',
	#category : #'BlocPac-Scrollable-Tree-Flow'
}

{ #category : #'api - scrolling thumb' }
TBlHorizontalTreeFlowLayoutSmooth >> computeHorizontalScrollExtent [
	"Compute the horizontal extent of the horizontal scrollbar's thumb within the horizontal range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollRange and #computeHorizontalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	^ self layout computeHorizontalScrollExtentIn: self
]

{ #category : #'api - scrolling thumb' }
TBlHorizontalTreeFlowLayoutSmooth >> computeHorizontalScrollOffset [
	"Compute the horizontal offset of the horizontal scrollbar's thumb within the horizontal range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollRange.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	^ self layout computeHorizontalScrollOffsetIn: self
]

{ #category : #'api - scrolling thumb' }
TBlHorizontalTreeFlowLayoutSmooth >> computeHorizontalScrollRange [
	"Compute the horizontal range that the horizontal scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollOffset.
	Default implementation returns 0.
	
	Override me in your scrollable element to support scroll bars"
	<return: #Number>
	
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	^ self layout computeHorizontalScrollRangeIn: self
]

{ #category : #'api - scrolling thumb' }
TBlHorizontalTreeFlowLayoutSmooth >> onLayout: aBounds context: aBlElementBoundsUpdater [
	| aPreviousMinPosition aCurrentMinPosition |
	super onLayout: aBounds context: aBlElementBoundsUpdater.

	aCurrentMinPosition := self userData
			at: #layoutNode
			ifPresent: [ :aParentNode | 
				| aMinChild |
				aMinChild := aParentNode children
						detectMin: [ :eachChildNode | eachChildNode position x ].
				aMinChild ifNotNil: [ aMinChild position x ] ]
			ifAbsent: [ ^ self ].

	aPreviousMinPosition := self userData
			at: #previousMinPosition
			ifAbsent: [ nil ].

	self userData at: #previousMinPosition put: aCurrentMinPosition.
	aPreviousMinPosition ifNil: [ ^ self ].

	self dispatchOnScrolled: aCurrentMinPosition - aPreviousMinPosition
]

{ #category : #'api - scrolling' }
TBlHorizontalTreeFlowLayoutSmooth >> scrollHorizontallyBy: aNumber [
	"Scroll horizontally by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."

	<return: #Number>
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	self layout scrollHorizontallyBy: aNumber in: self
]

{ #category : #'api - scrolling' }
TBlHorizontalTreeFlowLayoutSmooth >> scrollToColumn: aColumn [
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	self layout scrollToColumn: aColumn in: self
]

{ #category : #'api - smoothing' }
TBlHorizontalTreeFlowLayoutSmooth >> smoothNumberOfVisibleColumns: aColumnsCount [
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	self layout smoothNumberOfVisibleColumns: aColumnsCount in: self
]

{ #category : #'api - scrolling' }
TBlHorizontalTreeFlowLayoutSmooth >> smoothScrollToColumn: aColumn [
	self assert: [ self layout isKindOf: BlHorizontalTreeFlowLayout ].

	self layout smoothScrollToColumn: aColumn in: self
]
