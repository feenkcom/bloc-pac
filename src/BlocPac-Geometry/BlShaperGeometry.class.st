"
I am a geometry that uses a ${class:TBlShaperFigure}$ object to specify a geometrical area. I can match the extend of the element to which I am attached, when this extent changes.

!!Initialization
Users should use the method ${method:BlShaperGeometry>>#shape:}$ to specify a custom builder for creating ${class:TBlShaperFigure}$ objects having a given extent. I use this builder to update the geometry when the extent of the attached element changes (${method:BlShaperGeometry>>#extent:}$).
${example:BlShapeGeometryExample>>#geometryWithSimpleRectangleShape|previewExpanded=false|previewHeight=250}$

By default, in case no builder is provided, I use a builder that create an ${class:BlShaperPolygon}$ object. Hence, the previous example is equivalent to simply instantiating a ${class:BlShaperGeometry}$ (${method:BlShapeGeometryExample>>#defaultGeometry}$).

Since ${class:TBlShaperFigure}$ objects are polymorphic with blocks and can fit to fit a given rectangle, instances of ${class:TBlShaperFigure}$ can also directly be passed to ${method:BlShaperGeometry>>#shape:}$. In this case the extent used to instantiate the shape object is not take into account (${method:BlShapeGeometryExample>>#geometryWithRectangleShareInstance}$).

!!Usage
I can be directly attached to any graphical element, like any other geometry, and I will match the extend of the element. For example, below there are two examples, where the same ${class:BlShaperGeometry}$ is attached to two elements having a different extent.

${example:BlShapeGeometryExample>>#elementWithRectangleGeometry|previewExpanded=true|previewHeight=250}$
${example:BlShapeGeometryExample>>#elementLargeWithRectangleGeometry|previewExpanded=true|previewHeight=250}$
"
Class {
	#name : #BlShaperGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'shapeBuilder',
		'vectorShape'
	],
	#category : #'BlocPac-Geometry-Shaper'
}

{ #category : #sparta }
BlShaperGeometry >> buildPathOnSpartaCanvas: aCanvas [
	| aPathBuilder |
	
	aPathBuilder := aCanvas path.
	aPathBuilder moveTo: 0@0.
	vectorShape appendPathTo: aPathBuilder.
	^ aPathBuilder finish
]

{ #category : #private }
BlShaperGeometry >> createVectorShape [
	^ shapeBuilder value: (0@0 extent: extent)
]

{ #category : #geometry }
BlShaperGeometry >> extent: aPoint [
	super extent: aPoint.

	vectorShape := self createVectorShape.
	self releaseCache
]

{ #category : #testing }
BlShaperGeometry >> hasShapeBuilder [
	^ shapeBuilder notNil
]

{ #category : #initialization }
BlShaperGeometry >> initialize [
	super initialize.

	shapeBuilder := [ :aRectangle | BlShaperPolygon rectangle: aRectangle ].
	vectorShape := self createVectorShape
]

{ #category : #geometry }
BlShaperGeometry >> matchExtent: aPoint [
	self extent: aPoint
]

{ #category : #initialization }
BlShaperGeometry >> shape: aBlockOrVectorShape [
	"Initialize the geometry with a builder used to create a ${class:BlVectorShape}$ object with a given extent. The builder can be any object that understands ==value:==."
		
	self 
		assert: [ aBlockOrVectorShape notNil ] 
		description: 'The shape builder should not be nil.'.
	
	shapeBuilder := aBlockOrVectorShape.
	vectorShape := self createVectorShape.
	self releaseCache
]
