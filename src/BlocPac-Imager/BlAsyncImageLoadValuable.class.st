Class {
	#name : #BlAsyncImageLoadValuable,
	#superclass : #BlAsyncElementValuable,
	#category : #'BlocPac-Imager-TaskIt'
}

{ #category : #accessing }
BlAsyncImageLoadValuable >> cacheSize [
	"Answer the image size to retrieve from the cache.
	If the receiver's element has an extent, use that, otherwise the preLoad size"

	^self extent
		ifNil: [ element preLoad ]
		ifNotNil: [ :extent | extent max ]
]
