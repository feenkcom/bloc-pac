Class {
	#name : #BlFocusSearchDirectionBackward,
	#superclass : #BlFocusSearchDirectionRelative,
	#category : #'BlocPac-FocusFinder-Directions'
}

{ #category : #focus }
BlFocusSearchDirectionBackward >> initFocusedBounds: aFocusedBounds root: aFocusRootElement [

	aFocusRootElement layout isRightToLeft
		ifTrue: [ 
			aFocusedBounds
				left: 0
				top: 0
				right: 0
				bottom: 0 ]
		ifFalse: [
			aFocusedBounds
				left: aFocusRootElement width
				top: aFocusRootElement height
				right: aFocusRootElement width
				bottom: aFocusRootElement height ]
]

{ #category : #accessing }
BlFocusSearchDirectionBackward >> name [
	<return: #String>

	^ 'backward'
]

{ #category : #focus }
BlFocusSearchDirectionBackward >> nextFocus: aFocusedElement in: aCollectionOfElements within: aFocusRootElement from: aFocusedBounds finder: aFocusFinder [
	<return: #BlElement or: nil>
	
	| aCurrentFocusableIndex |
	aCollectionOfElements size < 2
		ifTrue: [ ^ nil ].
		
	aFocusedElement == aFocusRootElement
		ifTrue: [ ^ aCollectionOfElements at: 1 ].
		
	aCurrentFocusableIndex := aCollectionOfElements
		indexOf: aFocusedElement
		ifAbsent: [ ^ aCollectionOfElements at: 1 ].
		
	^ aCurrentFocusableIndex > 1
		ifTrue: [ aCollectionOfElements at: aCurrentFocusableIndex - 1 ]
		ifFalse: [ aCollectionOfElements at: aCollectionOfElements size ]
]

{ #category : #accessing }
BlFocusSearchDirectionBackward >> vector [
	^ BlVector2D x: -1 y: 0
]
