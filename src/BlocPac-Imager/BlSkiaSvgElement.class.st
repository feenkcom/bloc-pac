Class {
	#name : #BlSkiaSvgElement,
	#superclass : #BlElement,
	#instVars : [
		'svg',
		'dom',
		'session'
	],
	#category : #'BlocPac-Imager-Elements'
}

{ #category : #drawing }
BlSkiaSvgElement >> drawOnSpartaCanvas: aCanvas [
	super drawOnSpartaCanvas: aCanvas.

	svg
		ifNil: [ ^ self ].

	Smalltalk session == session ifFalse: [ 
		dom := nil ].


	dom ifNil: [
		dom := SkiaSvgDom parse: svg fontManager: SkiaFontManager default.
		session := Smalltalk session ].

	aCanvas surfaceCanvas
		drawSvg: dom
		at: 0@0.

	"ratio := (self extent x / image width min:
		          self extent y / image height) asFloat.
	imageExtent := image extent * ratio.
	translation := (self extent x - imageExtent x / 2.0
	                @ (self extent y - imageExtent y / 2.0))
		               asIntegerPoint.

	aCanvas transform
		by: [ :t | 
			t translateBy: translation.
			ratio isZero ifFalse: [ t scaleBy: ratio ] ]
		during: [ 
			aCanvas fill
				path: (0 @ 0 extent: image extent);
				paint: image;
				draw ]"
]

{ #category : #accessing }
BlSkiaSvgElement >> svg [
	^ svg
]

{ #category : #accessing }
BlSkiaSvgElement >> svg: anObject [
	svg := anObject
]
