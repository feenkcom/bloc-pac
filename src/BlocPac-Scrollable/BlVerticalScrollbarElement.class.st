Class {
	#name : #BlVerticalScrollbarElement,
	#superclass : #BlScrollbarElement,
	#category : #'BlocPac-Scrollable-Core'
}

{ #category : #initialization }
BlVerticalScrollbarElement >> defaultPullHandler [
	^ BlPullHandler new disallowOutOfBounds beVertical
]

{ #category : #initialization }
BlVerticalScrollbarElement >> defaultThumb [
	^ BlElement new
		width: 10;
		constraintsDo: [ :c |
			c vertical matchParent.
			c frame vertical weight: 0.25 ];
		background: Color gray
]

{ #category : #initialization }
BlVerticalScrollbarElement >> defaultTrack [
	<return: #BlElement>
	
	^ (BlElement new
		background: (Color black alpha: 0.25);
		constraintsDo: [ :c |
			c horizontal exact: 1.
			c vertical matchParent.
			c frame horizontal alignCenter ])
]

{ #category : #initialization }
BlVerticalScrollbarElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical matchParent ]
]

{ #category : #'private - scrolling' }
BlVerticalScrollbarElement >> scrollTo: aPoint [
	| scrollingBy oldPosition |
	oldPosition := dragPosition
			ifNil: [ self thumb position ]
			ifNotNil: [ dragPosition ].

	scrollingBy := self
			computeScrollDeltaFrom: oldPosition y
			to: aPoint y
			offset: scrollable computeVerticalScrollOffset
			range: scrollable computeVerticalScrollRange
			length: self height.

	scrollingBy isZero ifTrue: [ ^ self ].

	scrollable scrollBy: 0.0 @ scrollingBy.

	dragPosition
		ifNil: [ self thumb relocate: aPoint ]
		ifNotNil: [ dragPosition := aPoint ]
]

{ #category : #'private - scrolling' }
BlVerticalScrollbarElement >> updateScrollPosition [
	| verticalContentLength verticalScrollOffset verticalScrollExtent realThumbWeight thumbTop y |
	verticalContentLength := scrollable computeVerticalScrollRange.

	verticalContentLength isZero ifTrue: [ ^ self ].

	verticalScrollOffset := scrollable computeVerticalScrollOffset.
	verticalScrollExtent := scrollable computeVerticalScrollExtent.

	alwaysVisible
		ifFalse: [ verticalContentLength <= verticalScrollExtent
				ifTrue: [ self visibility: BlVisibility hidden ]
				ifFalse: [ self visibility: BlVisibility visible ] ].

	realThumbWeight := (verticalScrollExtent / verticalContentLength) asFloat
			max: 0.05.
	thumbTop := (verticalScrollOffset / verticalContentLength) asFloat
			min: 1.0 - realThumbWeight.

	y := self height * thumbTop.
	thumb
		constraintsDo: [ :c | 
			c vertical matchParent.
			c frame vertical
				alignTopAt: thumbTop;
				weight: realThumbWeight ].
	"relocate ensures that internal coordinates are consistent"
	thumb relocate: 0@y.
]
