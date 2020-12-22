Extension { #name : #BlElement }

{ #category : #'*BlocPac-Scalable' }
BlElement >> asScalableElement [
	| aScalableElement |
	
	self removeFromParent.
	aScalableElement := BlScalableElement new.
	aScalableElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	aScalableElement addChild: self.

	^ aScalableElement
]
