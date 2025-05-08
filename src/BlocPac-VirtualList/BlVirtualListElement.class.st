Class {
	#name : #BlVirtualListElement,
	#superclass : #BlElement,
	#category : #'BlocPac-VirtualList'
}

{ #category : #'as yet unclassified' }
BlVirtualListElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [
	
]

{ #category : #'as yet unclassified' }
BlVirtualListElement >> onMeasure: anExtentMeasurementSpec [
	| widthSpec heightSpec width height |

	widthSpec := anExtentMeasurementSpec widthSpec.
	heightSpec := anExtentMeasurementSpec heightSpec.

	width := widthSpec isUnspecified
		ifTrue: [ 0 ]
		ifFalse: [ widthSpec size ].
		
	width := width min: self constraints maxWidth.
		
	height := heightSpec isUnspecified
		ifTrue: [ 0 ]
		ifFalse: [ heightSpec size ].
		
	height := height min: self constraints maxHeight
]
