Class {
	#name : #BlFocusFinderReference,
	#superclass : #Object,
	#category : #'BlocPac-FocusFinder-Core'
}

{ #category : #'api - focus' }
BlFocusFinderReference >> focusBoundsIn: anElement direction: aFocusSearchDirection [
	<return: #Rectangle>
	
	^ self subclassResponsibility
]

{ #category : #'api - focus' }
BlFocusFinderReference >> focusElementIn: anElement [
	"Return a 'current' focused element which should be used a reference"
	<return: #BlElement>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlFocusFinderReference >> name [
	<return: #String>

	^ self subclassResponsibility
]
