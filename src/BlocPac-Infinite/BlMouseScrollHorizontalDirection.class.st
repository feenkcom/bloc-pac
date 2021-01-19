Class {
	#name : #BlMouseScrollHorizontalDirection,
	#superclass : #BlMouseScrollDirection,
	#category : #'BlocPac-Infinite-Basic'
}

{ #category : #'private - testing' }
BlMouseScrollHorizontalDirection >> canScrollLeft: anInfiniteElement [
	"Return true if an infinite element can be scrolled left"
	<return: #Boolean>	
	| aFirstChild |

	aFirstChild := anInfiniteElement layout childAtPosition: 1.
	aFirstChild
		ifNil: [ ^ true ].
		
	aFirstChild position x < (anInfiniteElement layout paddingLeft) 
		ifTrue: [ ^ true ].
		
	^ false
]

{ #category : #'private - testing' }
BlMouseScrollHorizontalDirection >> canScrollRight: anInfiniteElement [
	"Return true if an infinite element can be scrolled to the right"
	<return: #Boolean>	
	| aLastChild |
	
	aLastChild := anInfiniteElement layout childAtPosition: anInfiniteElement layout itemCount.
	aLastChild
		ifNil: [ ^ true ].

	aLastChild bounds inParent right > (anInfiniteElement weight - anInfiniteElement layout paddingRight) 
		ifTrue: [ ^ true ].

	^ false
]

{ #category : #'mouse handlers' }
BlMouseScrollHorizontalDirection >> mouseWheelEvent: anEvent [
	| dX anInfiniteElement isHorizontal |

	anEvent vector isZero
		ifTrue: [ ^ self ].

	anInfiniteElement := anEvent currentTarget.
	
	isHorizontal := anEvent vector x abs > anEvent vector y abs.
	
	isHorizontal ifFalse: [ ^ self ].

	dX := (anEvent isScrollLeft and: [ self canScrollLeft: anInfiniteElement ])
				ifTrue: [ anEvent vector length negated ]
				ifFalse: [ (anEvent isScrollRight and: [ self canScrollRight: anInfiniteElement ])
					ifTrue: [ anEvent vector length ]
					ifFalse: [ 0 ] ].

	BlMouseWheelEventSignal new
		event: anEvent;
		dX: dX;
		dY: 0;
		emit.

	dX isZero ifTrue: [ ^ self ].

	anInfiniteElement smoothScrollBy: (dX @ 0) * 10.
	anEvent consumed: true
]

{ #category : #accessing }
BlMouseScrollHorizontalDirection >> name [
	^ 'horizontal'
]
