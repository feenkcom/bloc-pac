Extension { #name : #BlElement }

{ #category : #'*BlocPac-PannableAndZoomable' }
BlElement >> asPannableElement [
	| pannable |
	self removeFromParent.
	pannable := BlPannableElement new.
	pannable contentElement: self.
	^ pannable
]
