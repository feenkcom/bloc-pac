Class {
	#name : #BlManhattanLineElement,
	#superclass : #BlCurveElement,
	#category : #'BlocPac-Geometry-Curves'
}

{ #category : #accessing }
BlManhattanLineElement >> beAutomatic [
	self invalidate.
	self geometry beAutomatic.
	self invalidate
]

{ #category : #'as yet unclassified' }
BlManhattanLineElement >> beFixedFrom [
	self geometry beFixedFrom
]

{ #category : #'as yet unclassified' }
BlManhattanLineElement >> beFixedTo [
	self geometry beFixedTo
]

{ #category : #accessing }
BlManhattanLineElement >> beHorizontal [
	self invalidate.
	self geometry beHorizontal.
	self invalidate
]

{ #category : #'as yet unclassified' }
BlManhattanLineElement >> beProportional [
	self geometry beProportional
]

{ #category : #accessing }
BlManhattanLineElement >> beVertical [
	self invalidate.
	self geometry beVertical.
	self invalidate
]

{ #category : #accessing }
BlManhattanLineElement >> cornerRadius: aNumber [
	self geometry cornerRadius: aNumber
]

{ #category : #initialization }
BlManhattanLineElement >> defaultGeometry [
	^BlManhattanLine new
]

{ #category : #'as yet unclassified' }
BlManhattanLineElement >> fixedDistance: aNumber [ 
	self geometry fixedDistance: aNumber
]

{ #category : #layout }
BlManhattanLineElement >> fromDirection [
	"Return a vector representing a direction in which start of the curve is pointing"

	<return: #BlVector>
	^ (self geometry isHorizontal
		ifTrue: [ ((self fromPosition x - self toPosition x) @ 0) ]
		ifFalse: [ 0 @ (self fromPosition y - self toPosition y) ]) asBlocVector
]

{ #category : #layout }
BlManhattanLineElement >> layoutBounds [
	| anOrigin aCorner |
	<return: #Rectangle>	

	anOrigin := self fromPosition.
	aCorner := self toPosition.

	^ Rectangle encompassing: { anOrigin. aCorner }
]

{ #category : #layout }
BlManhattanLineElement >> measureGeometry [
	| aDecoratedFromPoint aDecoratedToPoint aDelta |

	aDecoratedFromPoint := self decoratedFromPosition.
	aDecoratedToPoint := self decoratedToPosition.

	aDelta := self fromPosition min: self toPosition.
	
	self geometry from: aDecoratedFromPoint - aDelta to: aDecoratedToPoint - aDelta
]

{ #category : #'as yet unclassified' }
BlManhattanLineElement >> proportion: aFloat [ 
	self geometry proportion: aFloat
]

{ #category : #layout }
BlManhattanLineElement >> toDirection [
	"Return a vector representing a direction in which the end of the curve is pointing"

	<return: #BlVector>
	^ (self geometry isHorizontal
		ifTrue: [ (self toPosition x - self fromPosition x) @ 0 ]
		ifFalse: [ 0 @ (self toPosition y - self fromPosition y) ]) asBlocVector
]
