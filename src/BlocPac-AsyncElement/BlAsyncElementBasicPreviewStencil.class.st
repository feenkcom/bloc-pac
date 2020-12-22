"
I represent a basic preview stencil for ${class:BlAsyncDelayedPreviewStrategy}$. 

I generate the following preview: ${example:BlAsyncElementExamples>>#previewStencil|codeExpanded=false|previewExpanded=true}$
"
Class {
	#name : #BlAsyncElementBasicPreviewStencil,
	#superclass : #BlAsyncElementPreviewStencil,
	#category : #'BlocPac-AsyncElement'
}

{ #category : #'api - instantiation' }
BlAsyncElementBasicPreviewStencil >> create [
	^ BlElement new
		background: Color veryVeryLightGray;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ]
]
