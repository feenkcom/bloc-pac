Class {
	#name : #BlSplineOverScrollerCubicStep,
	#superclass : #BlSplineOverScrollerStep,
	#category : #'BlocPac-Scrollable-Helpers'
}

{ #category : #hooks }
BlSplineOverScrollerCubicStep >> onFinished: aSplineOverScroller [
	"Cubic means no spring back, simply finish"
	<return: #Boolean>
	
	^ false
]
