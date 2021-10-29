"
I am a root class of geometry elements - elements driven by geometry anchors.

"
Class {
	#name : #BlAnchoredElement,
	#superclass : #BlElement,
	#instVars : [
		'commonParentDetector',
		'anchorEventListener'
	],
	#category : #'BlocPac-Geometry-Base'
}

{ #category : #layout }
BlAnchoredElement >> applyLayoutIn: aBounds context: aBlElementBoundsUpdateContext [
	super applyLayoutIn: self layoutBounds context: aBlElementBoundsUpdateContext
]

{ #category : #initialization }
BlAnchoredElement >> defaultLayout [
	^ BlAnchoredLayout new
]

{ #category : #initialization }
BlAnchoredElement >> initialize [
	super initialize.
	
	commonParentDetector := BlCommonParentDetector forElements: { self }.
	anchorEventListener := BlAnchorEventListener for: self.
]

{ #category : #layout }
BlAnchoredElement >> layoutBounds [
	"Compute and return layout bounds based on geometry anchors.
	The bounds origin describes a position of this geometry element
	within its parent, while bounds extent describes my extent"
	<return: #Rectangle>
	
	^ self subclassResponsibility
]

{ #category : #layout }
BlAnchoredElement >> measureGeometry [
	"Adapt underlying geometry to fit anchor positions"

	self subclassResponsibility
]

{ #category : #anchors }
BlAnchoredElement >> onAnchorMoved [
	"I am sent after any of my anchors moves"

	self requestLayout
]

{ #category : #layout }
BlAnchoredElement >> onMeasure: anExtentMeasurementSpec [
	self measureGeometry.
	super onMeasure: anExtentMeasurementSpec
]

{ #category : #anchors }
BlAnchoredElement >> registerAnchor: aGeometryAnchor [
	"Register a given geometry anchor as one of my anchors"

	aGeometryAnchor attachToAnchoredElement: self
]

{ #category : #anchors }
BlAnchoredElement >> registerDependentElement: anElement [
	commonParentDetector addElement: anElement.
	anElement addEventHandler: anchorEventListener
]

{ #category : #anchors }
BlAnchoredElement >> unregisterAnchor: aGeometryAnchor [
	"Unregister a given geometry anchor from being one of my anchors"
	aGeometryAnchor detachFromAnchoredElement: self
]

{ #category : #anchors }
BlAnchoredElement >> unregisterDependentElement: anElement [
	commonParentDetector removeElement: anElement.
	anElement removeEventHandler: anchorEventListener
]
