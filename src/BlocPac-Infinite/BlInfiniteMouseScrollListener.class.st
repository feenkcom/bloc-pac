Class {
	#name : #BlInfiniteMouseScrollListener,
	#superclass : #BlBasicEventHandler,
	#category : #'BlocPac-Infinite-Basic'
}

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> canScrollDown: anInfiniteElement [
	"Return true if an infinite element can be scrolled down"
	<return: #Boolean>	
	| aLastChild |
	
	aLastChild := anInfiniteElement layout childAtPosition: anInfiniteElement layout itemCount.
	aLastChild
		ifNil: [ ^ true ].

	aLastChild bounds inParent bottom > (anInfiniteElement height - anInfiniteElement layout paddingBottom) 
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> canScrollUp: anInfiniteElement [
	"Return true if an infinite element can be scrolled up"
	<return: #Boolean>	
	| aFirstChild |

	aFirstChild := anInfiniteElement layout childAtPosition: 1.
	aFirstChild
		ifNil: [ ^ true ].

	aFirstChild position y < (anInfiniteElement layout paddingTop) 
		ifTrue: [ ^ true ].
		
	^ false
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> doScrollDown: anEvent [
	| aVectorLength anInfiniteElement |
	aVectorLength := anEvent vector y abs.

	anInfiniteElement := anEvent currentTarget.
	anInfiniteElement isNestedScrollingEnabled ifFalse: [ ^ aVectorLength ].
	self
		withInfiniteParentAndChildOf: anInfiniteElement
		do: [ :aParentInfiniteElement :aChildOfInfiniteElement | 
			| theBoundsInParent availableSpaceBelow |
			theBoundsInParent := aChildOfInfiniteElement bounds inParent.
			availableSpaceBelow := aParentInfiniteElement bounds bottom
					- theBoundsInParent bottom.
			availableSpaceBelow < 0
				ifTrue: [ | howMuchWeScroll howMuchTheyScroll |
					"aVectorLength <= availableSpaceBelow abs ifTrue: [ ^ 0 ]."
					howMuchTheyScroll := availableSpaceBelow.
					howMuchWeScroll := aVectorLength - howMuchTheyScroll.

					anEvent
						vector: (BlVector x: anEvent vector x y: anEvent vector y sign * howMuchTheyScroll).
					^ howMuchWeScroll ] ].
	^ aVectorLength
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> doScrollUp: anEvent [
	| aVectorLength anInfiniteElement |
	aVectorLength := anEvent vector y abs.

	anInfiniteElement := anEvent currentTarget.
	anInfiniteElement isNestedScrollingEnabled ifFalse: [ ^ aVectorLength negated ].
	self
		withInfiniteParentAndChildOf: anInfiniteElement
		do: [ :aParentInfiniteElement :aChildOfInfiniteElement | 
			| theBoundsInParent availableSpaceAbove |
			theBoundsInParent := aChildOfInfiniteElement bounds inParent.
			availableSpaceAbove := theBoundsInParent top
					- aChildOfInfiniteElement margin top.

			availableSpaceAbove < 0
				ifTrue: [ | howMuchWeScroll howMuchTheyScroll |
					"aVectorLength <= availableSpaceAbove abs
											ifTrue: [ ^ 0 ]."
					howMuchTheyScroll := availableSpaceAbove abs.
					howMuchWeScroll := aVectorLength - howMuchTheyScroll.
					anEvent
						vector: (BlVector x: anEvent vector x y: anEvent vector y sign * howMuchTheyScroll).

					^ howMuchWeScroll negated ] ].

	^ aVectorLength negated
]

{ #category : #accessing }
BlInfiniteMouseScrollListener >> eventClass [
	^ BlMouseWheelEvent
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> handleEvent: anEvent [
	anEvent sendTo: self
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> mouseWheelEvent: anEvent [
	| dX dY anInfiniteElement isHorizontal |
	anEvent vector isZero ifTrue: [ ^ self ].

	anInfiniteElement := anEvent currentTarget.
	isHorizontal := anEvent isPrimarilyHorizontal.

	dX := isHorizontal
			ifTrue: [ anEvent vector length * anEvent vector x sign ]
			ifFalse: [ 0 ].

	dY := isHorizontal not
			ifTrue: [ (anEvent isScrollDown and: [ self canScrollDown: anInfiniteElement ])
					ifTrue: [ self doScrollDown: anEvent ]
					ifFalse: [ (anEvent isScrollUp and: [ self canScrollUp: anInfiniteElement ])
							ifTrue: [ self doScrollUp: anEvent ]
							ifFalse: [ 0 ] ] ]
			ifFalse: [ 0 ].
	anInfiniteElement smoothScrollBy: (dX @ dY) * 10
]

{ #category : #printing }
BlInfiniteMouseScrollListener >> printOn: aStream [
	aStream 
		nextPutAll: 'Event handler of ';
		print: self eventClass.
]

{ #category : #events }
BlInfiniteMouseScrollListener >> wantsEvent: anEvent [
	^ anEvent class == self eventClass or: [ anEvent class inheritsFrom: self eventClass ]
]

{ #category : #private }
BlInfiniteMouseScrollListener >> withInfiniteParentAndChildOf: anInfiniteElement do: aBlock [
	anInfiniteElement
		allParentsDetect: [ :each | each isKindOf: BlInfiniteElement ]
		ifFound: [ :aParentInfiniteElement | 
			aParentInfiniteElement canScrollVertically
				ifTrue: [ anInfiniteElement
						allParentsDetect: [ :each | each parent == aParentInfiniteElement ]
						ifFound: [ :aChildOfInfiniteElement | aBlock value: aParentInfiniteElement value: aChildOfInfiniteElement ]
						ifNone: [  ] ] ]
		ifNone: [  ]
]
