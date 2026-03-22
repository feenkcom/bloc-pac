Class {
	#name : #BlFormElement,
	#superclass : #BlElement,
	#instVars : [
		'form',
		'image'
	],
	#category : #'BlocPac-Imager-Elements'
}

{ #category : #'instance creation' }
BlFormElement class >> fromForm: aForm [
	^ self new form: aForm
]

{ #category : #accessing }
BlFormElement >> form [
	^ form
]

{ #category : #accessing }
BlFormElement >> form: aForm [
	form := aForm.
	image := (SkiaImage fromForm: aForm) asElement
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].
			
	self size: form extent.
	self removeChildren.
	self addChild: image
]

{ #category : #layout }
BlFormElement >> onMeasure: anExtentMeasurementSpec [
	| logicalExtent |
	
	logicalExtent := form extent.
	self spaceDo: [ :aSpace |
		aSpace hostSpaceDo: [ :aHostSpace | logicalExtent := logicalExtent / aHostSpace scaleFactor ] ].
		
	self constraints horizontal exact: logicalExtent x.
	self constraints vertical exact: logicalExtent y.

	super onMeasure: (BlExtentMeasurementSpec exact: logicalExtent)
]
