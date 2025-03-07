Class {
	#name : #BlHorizontalScrollbarElement,
	#superclass : #BlScrollbarElement,
	#category : #'BlocPac-Scrollable-Core'
}

{ #category : #initialization }
BlHorizontalScrollbarElement >> defaultPullHandler [
	^ BlPullHandler new beHorizontal
]

{ #category : #initialization }
BlHorizontalScrollbarElement >> defaultThumb [
	^ BlElement new
		height: 8;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c frame horizontal weight: 0.25.
			c frame vertical alignCenter ];
		background: Color gray
]

{ #category : #initialization }
BlHorizontalScrollbarElement >> defaultTrack [
	<return: #BlElement>
	
	^ (BlElement new
		background: (Color black alpha: 0.25);
		constraintsDo: [ :c |
			c vertical exact: 1.
			c horizontal matchParent.
			c frame vertical alignCenter ])
]

{ #category : #initialization }
BlHorizontalScrollbarElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ]
]

{ #category : #'private - scrolling' }
BlHorizontalScrollbarElement >> scrollTo: aPoint [
	| scrollingBy oldPosition |
	oldPosition := dragPosition
			ifNil: [ self thumb position ]
			ifNotNil: [ dragPosition ].

	scrollingBy := self
		computeScrollDeltaFrom: oldPosition x
		to: aPoint x
		offset: scrollable computeHorizontalScrollOffset
		range: scrollable computeHorizontalScrollRange
		length: self width.

	scrollingBy isZero ifTrue: [ ^ self ].

	scrollable scrollBy: scrollingBy @ 0.

	dragPosition
		ifNil: [ self thumb relocate: aPoint ]
		ifNotNil: [ dragPosition := aPoint ]
]

{ #category : #'private - scrolling' }
BlHorizontalScrollbarElement >> updateScrollPosition [
	| horizontalContentLength horizontalScrollOffset horizontalScrollExtent realThumbWeight thumbLeft x |
	
	horizontalContentLength := scrollable computeHorizontalScrollRange.
	
	horizontalContentLength isZero
		ifTrue: [ ^ self ].
	
	horizontalScrollOffset := scrollable computeHorizontalScrollOffset.
	horizontalScrollExtent := scrollable computeHorizontalScrollExtent.
	
	alwaysVisible ifFalse: [ 
		horizontalContentLength <= horizontalScrollExtent 
			ifTrue: [ self visibility: BlVisibility hidden]
			ifFalse: [ self visibility: BlVisibility visible] ].
	
	realThumbWeight := (horizontalScrollExtent / horizontalContentLength) asFloat.
	thumbLeft := (horizontalScrollOffset / horizontalContentLength) asFloat.
	
	x := self width * thumbLeft.
	thumb constraintsDo: [ :c | 
		c horizontal matchParent.
		c frame horizontal
			alignLeftAt: thumbLeft;
			weight: realThumbWeight ].
	thumb relocate: x@0.
]
