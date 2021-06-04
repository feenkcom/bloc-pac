"
I represent a basic preview stencil for {{gtClass:BlAsyncDelayedPreviewStrategy}}. 

I generate the following preview: {{gtExample:BlAsyncElementExamples>>#previewStencil|codeExpanded=false|previewExpanded=true}}

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
