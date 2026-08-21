Extension { #name : #SkiaImage }

{ #category : #'*BlocPac-Imager' }
SkiaImage >> asElement [
	^ (BlSkiaImageElement new image: self) size: self extent
]
