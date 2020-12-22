Extension { #name : #BlElement }

{ #category : #'*BlocPac-Scrollable' }
BlElement >> asScrollableElement [
	| scrollable |
	self removeFromParent.
	scrollable := BlScrollableElement new.
	scrollable constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scrollable addChild: self.
	^ scrollable
]
