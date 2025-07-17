Class {
	#name : #BlResizerEvent,
	#superclass : #BlEvent,
	#instVars : [
		'modifiers'
	],
	#category : #'BlocPac-Resizable'
}

{ #category : #accessing }
BlResizerEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
BlResizerEvent >> modifiers: anObject [
	modifiers := anObject
]
