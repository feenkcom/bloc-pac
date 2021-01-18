Class {
	#name : #BlMouseScrollVerticalDirection,
	#superclass : #BlMouseScrollDirection,
	#category : #'BlocPac-Infinite-Basic'
}

{ #category : #'private - testing' }
BlMouseScrollVerticalDirection >> canScrollDown: anInfiniteElement [
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

{ #category : #'private - testing' }
BlMouseScrollVerticalDirection >> canScrollUp: anInfiniteElement [
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
BlMouseScrollVerticalDirection >> mouseWheelEvent: anEvent [
	| dY anInfiniteElement isHorizontal |

	anEvent vector isZero ifTrue: [ ^ self ].

	anInfiniteElement := anEvent currentTarget.
	
	isHorizontal := anEvent vector x abs > anEvent vector y abs.
	isHorizontal ifTrue: [ ^ self ].

	dY := (anEvent isScrollDown and: [ self canScrollDown: anInfiniteElement ])
				ifTrue: [ anEvent vector length ]
				ifFalse: [ (anEvent isScrollUp and: [ self canScrollUp: anInfiniteElement ])
					ifTrue: [ anEvent vector length negated ]
					ifFalse: [ 0 ] ].

	BlMouseWheelEventSignal new
		event: anEvent;
		dX: 0;
		dY: dY;
		emit.

	dY isZero ifTrue: [ ^ self ].

	anInfiniteElement smoothScrollBy: (0 @ dY) * 10.
	anEvent consumed: true.
]

{ #category : #accessing }
BlMouseScrollVerticalDirection >> name [
	^ 'vertical'
]
