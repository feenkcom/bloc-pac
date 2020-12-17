Extension { #name : #AbstractFileReference }

{ #category : #'*BlocPac-Imager' }
AbstractFileReference >> gtBinaryContents [
	self binaryReadStreamDo: [ :stream |
		^ stream contents ]
]
