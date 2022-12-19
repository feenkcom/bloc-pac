Class {
	#name : #BlFocusFinderReferenceNone,
	#superclass : #BlFocusFinderReference,
	#classTraits : 'TBlDebug classTrait',
	#category : #'BlocPac-FocusFinder-Core'
}

{ #category : #'api - focus' }
BlFocusFinderReferenceNone >> focusBoundsIn: anElement direction: aFocusSearchDirection [
	<return: #Rectangle>
	| theBounds |
	
	theBounds := BlBounds new.

	aFocusSearchDirection
		initFocusedBounds: theBounds
		root: anElement.

	^ theBounds asRectangle
]

{ #category : #'api - focus' }
BlFocusFinderReferenceNone >> focusElementIn: anElement [
	"Return a 'current' focused element which should be used a reference"
	<return: #BlElement>

	^ anElement
]

{ #category : #accessing }
BlFocusFinderReferenceNone >> name [
	<return: #String>

	^ 'None'
]
