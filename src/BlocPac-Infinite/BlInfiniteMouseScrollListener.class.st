Class {
	#name : #BlInfiniteMouseScrollListener,
	#superclass : #BlBasicEventHandler,
	#category : #'BlocPac-Infinite-Basic'
}

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> doScrollDown: anEvent [
	| aVectorLength anInfiniteElement |
	aVectorLength := anEvent vector y abs.

	anInfiniteElement := anEvent currentTarget.
	anInfiniteElement isNestedScrollingEnabled
		ifTrue: [ anInfiniteElement
				allParentsDetect: [ :each | each isKindOf: BlInfiniteElement ]
				ifFound: [ :aParentInfiniteElement | 
					aParentInfiniteElement canScrollVertically
						ifTrue: [ anInfiniteElement
								allParentsDetect: [ :each | each parent == aParentInfiniteElement ]
								ifFound: [ :aChildOfInfiniteElement | 
									| theBoundsInParent availableSpaceBelow |
									theBoundsInParent := aChildOfInfiniteElement bounds inParent.
									availableSpaceBelow := aParentInfiniteElement bounds bottom - theBoundsInParent bottom.

									availableSpaceBelow < 0
										ifTrue: [ | howMuchWeScroll howMuchTheyScroll |
										
											"if there is enough space above to accomodate the whole event, then be it"
											aVectorLength <= availableSpaceBelow abs ifTrue: [ ^ 0 ].
											howMuchTheyScroll := availableSpaceBelow.
											
											"there is not enough space above for the whole event. we have to scroll a bit"
											howMuchWeScroll := aVectorLength - howMuchTheyScroll.

											anEvent
												vector: (BlVector x: anEvent vector x y: anEvent vector y sign * howMuchTheyScroll).	
												
											"wants to scroll by a greater distance then we have"
											^ howMuchWeScroll ] ]
								ifNone: [  ] ] ]
				ifNone: [  ] ].	
				
	"consume in default case"
	anEvent consumed: aVectorLength isZero not.

	^ aVectorLength
]

{ #category : #'mouse handlers' }
BlInfiniteMouseScrollListener >> doScrollUp: anEvent [
	| aVectorLength anInfiniteElement |

	aVectorLength := anEvent vector y abs.

	anInfiniteElement := anEvent currentTarget.
	anInfiniteElement isNestedScrollingEnabled ifTrue: [
		anInfiniteElement
			allParentsDetect: [ :each | each isKindOf: BlInfiniteElement ]
			ifFound: [ :aParentInfiniteElement | 
				aParentInfiniteElement canScrollVertically
					ifTrue: [
						anInfiniteElement
							allParentsDetect: [ :each | each parent == aParentInfiniteElement]
							ifFound: [ :aChildOfInfiniteElement |
								| theBoundsInParent availableSpaceAbove |

								theBoundsInParent := aChildOfInfiniteElement bounds inParent.
								availableSpaceAbove := theBoundsInParent top - aChildOfInfiniteElement margin top.
		
								availableSpaceAbove < 0
									ifTrue: [
										| howMuchWeScroll howMuchTheyScroll |
										
										"if there is enough space above to accomodate the whole event, then be it"
										aVectorLength <= availableSpaceAbove abs
											ifTrue: [ ^ 0 ].
				
										howMuchTheyScroll := availableSpaceAbove abs.
										
										"there is not enough space above for the whole event. we have to scroll a bit"
										howMuchWeScroll := aVectorLength - howMuchTheyScroll.
				
										anEvent vector: (BlVector x: anEvent vector x y: (anEvent vector y sign * howMuchTheyScroll)).
				
										^ howMuchWeScroll negated ] ]
							ifNone: [ ] ] ]
			ifNone: [  ] ].

	"consume in default case"
	anEvent consumed: aVectorLength isZero not.

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
	| dX dY anInfiniteElement isVertical scrollDelta scrollDeltaX scrollDeltaY |
	anEvent vector isZero ifTrue: [ ^ self ].

	anInfiniteElement := anEvent currentTarget.
	isVertical := anEvent isPrimarilyHorizontal not.	"(anInfiniteElement childrenManager hasChildren and: isVertical)
		ifTrue: [ (anInfiniteElement childrenManager firstVisibleChild query
				// BlInfiniteElement) anyOne
				ifNotNil: [ :child | 
					child layout canScrollVertically
						ifTrue: [ (anEvent isScrollDown and: [ child canScrollDown ])
								ifTrue: [ child fireEvent: anEvent.
									^ self ].
							child asBeaconSignal emit.
							(anEvent isScrollUp
								and: [ child canScrollUp and: [ (child layout childAtPosition: 1) notNil ] ])
								ifTrue: [ child fireEvent: anEvent.
									^ self ] ] ].
			(anInfiniteElement childrenManager lastVisibleChild query
				// BlInfiniteElement) anyOne
				ifNotNil: [ :child | 
					child layout canScrollVertically
						ifTrue: [ (anEvent isScrollDown and: [ child canScrollDown ])
								ifTrue: [ child fireEvent: anEvent.
									^ self ].
							(anEvent isScrollUp
								and: [ child canScrollUp and: [ (child layout childAtPosition: 1) notNil ] ])
								ifTrue: [ child fireEvent: anEvent.
									^ self ] ] ] ]."

	dX := isVertical
			ifTrue: [ 0 ]
			ifFalse: [ anEvent vector length * anEvent vector x sign ].

	dY := isVertical
			ifTrue: [ (anEvent isScrollDown and: [ anInfiniteElement canScrollDown ])
					ifTrue: [ self doScrollDown: anEvent ]
					ifFalse: [ (anEvent isScrollUp and: [ anInfiniteElement canScrollUp ])
							ifTrue: [ self doScrollUp: anEvent ]
							ifFalse: [ 0 ] ] ]
			ifFalse: [ 0 ].

	scrollDeltaX := anEvent isPixelBased ifTrue: [ dX * 10 ] ifFalse: [ dX ].
	scrollDeltaY := dY * 10.

	scrollDelta := scrollDeltaX @ scrollDeltaY.
	anInfiniteElement smoothScrollBy: scrollDelta
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
