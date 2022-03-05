"
I represent an abstract preview stencil for {{gtClass:BlAsyncDelayedPreviewStrategy}}. 
I am here more for documentation purposes as the {{gtMethod:BlAsyncDelayedPreviewStrategy>>#previewStencil:}} can receive any stencil that understands the {{gtMethod:BrStencil>>#asElement|label=#selector}} method.
 
See {{gtClass:BlAsyncDelayedPreviewStrategy}} and my subclasses for more details: {{gtClass:BlAsyncElementPreviewStencil|show=#gtSubclassesFor:|expanded=true|height=150}}

"
Class {
	#name : #BlAsyncElementPreviewStencil,
	#superclass : #BrStencil,
	#category : #'BlocPac-AsyncElement'
}

{ #category : #testing }
BlAsyncElementPreviewStencil class >> isAbstract [
	^ self name = #BlAsyncElementPreviewStencil 
]
