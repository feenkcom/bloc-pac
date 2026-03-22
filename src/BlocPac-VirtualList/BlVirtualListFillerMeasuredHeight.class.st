Class {
	#name : #BlVirtualListFillerMeasuredHeight,
	#superclass : #Object,
	#instVars : [
		'height'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #'accumulator ops' }
BlVirtualListFillerMeasuredHeight >> += aNumber [
	height := height + aNumber
]

{ #category : #converting }
BlVirtualListFillerMeasuredHeight >> asNumber [
	^ height
]

{ #category : #initialization }
BlVirtualListFillerMeasuredHeight >> initialize [
	super initialize.
	
	height := 0
]
