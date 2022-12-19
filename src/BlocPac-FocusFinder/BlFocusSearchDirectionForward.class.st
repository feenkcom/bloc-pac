Class {
	#name : #BlFocusSearchDirectionForward,
	#superclass : #BlFocusSearchDirectionRelative,
	#category : #'BlocPac-FocusFinder-Directions'
}

{ #category : #focus }
BlFocusSearchDirectionForward >> initFocusedBounds: aFocusedBounds root: aFocusRootElement [

	aFocusRootElement layout isRightToLeft
		ifTrue: [ aFocusedBounds
			left: aFocusRootElement width
			top: aFocusRootElement height
			right: aFocusRootElement width
			bottom: aFocusRootElement height ]
		ifFalse: [
			aFocusedBounds
				left: 0
				top: 0
				right: 0
				bottom: 0 ]
]

{ #category : #accessing }
BlFocusSearchDirectionForward >> name [
	<return: #String>

	^ 'forward'
]

{ #category : #focus }
BlFocusSearchDirectionForward >> nextFocus: aFocusedElement in: aCollectionOfElements within: aFocusRootElement from: aFocusedBounds finder: aFocusFinder [
	<return: #BlElement or: nil>
	| aCurrentFocusableIndex |
	
	aCollectionOfElements size < 2
		ifTrue: [ ^ nil ].
	
	aFocusedElement == aFocusRootElement
		ifTrue: [ ^ aCollectionOfElements at: 1 ].
		
	aCurrentFocusableIndex := aCollectionOfElements
		indexOf: aFocusedElement
		ifAbsent: [ ^ aCollectionOfElements at: 1 ].
		
	^ aCurrentFocusableIndex < aCollectionOfElements size
		ifTrue: [ aCollectionOfElements at: aCurrentFocusableIndex + 1 ]
		ifFalse: [ aCollectionOfElements at: 1 ]
]

{ #category : #accessing }
BlFocusSearchDirectionForward >> vector [
	^ BlVector2D x: 1 y: 0
]
