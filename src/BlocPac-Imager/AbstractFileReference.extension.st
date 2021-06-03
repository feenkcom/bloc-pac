Extension { #name : #AbstractFileReference }

{ #category : #'*BlocPac-Imager' }
AbstractFileReference >> gtBinaryContents [

	self isDirectory ifTrue: 
		[ self error: 'Directory contents cannot be read in a stream' ].
	self binaryReadStreamDo: [ :stream |
		^ stream contents ]
]
