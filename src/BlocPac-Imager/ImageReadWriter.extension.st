Extension { #name : #ImageReadWriter }

{ #category : #'*BlocPac-Imager' }
ImageReadWriter class >> gtFormFromBuffer: aByteArray [
	<return: #Form>

	| stream readerClass form |

	stream := aByteArray readStream.
	form := [
		readerClass := self readerClassFromStream: stream.
		readerClass gtFromBuffer: aByteArray ]
			ensure: [ stream close ].
	^ form

]

{ #category : #'*BlocPac-Imager' }
ImageReadWriter class >> gtFromBuffer: aByteArray [

	^(self new on: aByteArray readStream) nextImage
]
