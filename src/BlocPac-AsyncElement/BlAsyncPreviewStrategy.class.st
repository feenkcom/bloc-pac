"
I am a {{gtClass:BlAsyncElement}} preview strategy.
I know how to render a preview that is displayed while waiting to calculate an expected {{gtClass:BlElement}}.

My subclasses needs to implement {{gtMethod:BlAsyncPreviewStrategy>>#schedulePreviewIn:}}.

See my subclasses for more details: {{gtClass:BlAsyncPreviewStrategy|show=#gtSubclassesFor:|height=150|expanded=true}}


"
Class {
	#name : #BlAsyncPreviewStrategy,
	#superclass : #Object,
	#category : #'BlocPac-AsyncElement'
}

{ #category : #factory }
BlAsyncPreviewStrategy class >> delayedStencil: aStencil [
	^ BlAsyncDelayedPreviewStrategy new previewStencil: aStencil
]

{ #category : #factory }
BlAsyncPreviewStrategy class >> null [
	^ BlAsyncNoPreviewStrategy default
]

{ #category : #scheduling }
BlAsyncPreviewStrategy >> schedulePreviewIn: anElement [
	"schedule a preview and add it to the anElement"
	self subclassResponsibility
]
