Extension { #name : #BlElement }

{ #category : #'*BlocPac-PannableAndZoomable' }
BlElement >> asCanvassableElement [
	| canvassable |
	self removeFromParent.
	canvassable := BlCanvassableElement new.
	canvassable
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	canvassable addChild: self.
	^ canvassable
]

{ #category : #'*BlocPac-PannableAndZoomable' }
BlElement >> asPannableElement [
	| pannable |
	self removeFromParent.
	pannable := BlPannableElement new.
	pannable contentElement: self.
	^ pannable
]
