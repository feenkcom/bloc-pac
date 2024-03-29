Class {
	#name : #BlFocusFinderReferenceElement,
	#superclass : #BlFocusFinderReference,
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'element'
	],
	#category : #'BlocPac-FocusFinder-Core'
}

{ #category : #accessing }
BlFocusFinderReferenceElement >> element [
	^ element
]

{ #category : #accessing }
BlFocusFinderReferenceElement >> element: anObject [
	element := anObject
]

{ #category : #'api - focus' }
BlFocusFinderReferenceElement >> focusBoundsIn: anElement direction: aFocusSearchDirection [
	<return: #Rectangle>
	
	^ (anElement
		localBoundsToMine: (self element focusedBounds: BlBounds new)
		fromChild: self element) asRectangle
]

{ #category : #'api - focus' }
BlFocusFinderReferenceElement >> focusElementIn: anElement [
	"Return a 'current' focused element which should be used a reference"
	<return: #BlElement>

	^ self element
]

{ #category : #accessing }
BlFocusFinderReferenceElement >> name [
	<return: #String>

	^ 'element'
]
