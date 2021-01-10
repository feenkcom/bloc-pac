Class {
	#name : #GToolkitImagesExamples,
	#superclass : #Object,
	#category : #'BlocPac-Imager-Examples-Examples'
}

{ #category : #examples }
GToolkitImagesExamples >> gridElementForDirectory: aFileReference [
	"Answer an element that displays the images in aFileReference in a grid"

	| gridElement scrollPane jpgs previewSize children |

	gridElement := BlElement new.
	"gridElement layout: (BlGridLayout new columnCount: 2; cellSpacing: 2)."
	gridElement layout: BlFlowLayout new.
	gridElement constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].

	jpgs := aFileReference asFileReference children sorted
		select: [ :each | each extension asLowercase = 'jpg' ].
	previewSize := 200@200.
	children :=  jpgs collect: [ :file |
			BlFileImageElement new 
				size: previewSize;
				file: file;
				yourself ].
	children size >= 5 ifTrue:
		[ (children at: 5) priority: 0 ].

	gridElement addChildren: children.
	scrollPane := BlScrollableElement new.
	scrollPane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scrollPane addChild: gridElement.

	^scrollPane
]

{ #category : #examples }
GToolkitImagesExamples >> gridSpaceForDirectory: aFileReference [
	"Open a BlSpace that displays the images in aFileReference in a grid"

	| scrollPane space |

	scrollPane := self gridElementForDirectory: aFileReference.

	space := BlSpace new.
	space root addChild: scrollPane.
	space title: 'Gallery on: ', aFileReference asFileReference pathString.
	space show.
	^space
]

{ #category : #examples }
GToolkitImagesExamples >> imageInSpace: aFileReference [

	| element space |

	element := BlFileImageElement new.
	element file: aFileReference asFileReference.
	element constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].

	space := BlSpace new.
	space root addChild: element.
	space title: aFileReference asFileReference basename.
	space show.
	^space
]

{ #category : #examples }
GToolkitImagesExamples >> urlGrid [
	<gtExample>
	<noTest>

	| images gridElement scrollPane previewSize children |

	images := STONJSON fromString: 'https://unsplash.it/list' asUrl retrieveContents.

	gridElement := BlElement new.
	gridElement layout: (BlGridLayout new columnCount: 2; cellSpacing: 2).
	gridElement constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].

	previewSize := 200@200.
	children := OrderedCollection new.
	30 timesRepeat: [ 
		children add: (BlUrlImageElement new 
			size: previewSize;
			url: 'https://unsplash.it/200/100?image=', (images atRandom at: 'id') asString) ].

	gridElement addChildren: children.
	scrollPane := BlScrollableElement new.
	scrollPane constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	scrollPane addChild: gridElement.

	^ scrollPane
]

{ #category : #examples }
GToolkitImagesExamples >> urlImage [
	<gtExample>
	<noTest>
	| url element |

	url := 'https://picsum.photos/200/100'.

	element := BlUrlImageElement url: url.
	element constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].

	^ element
]
