Class {
	#name : #BlDevScripterInteractionStep,
	#superclass : #BlDevScripterTargetedStep,
	#category : #'BlocPac-Scripter-Scripter-Steps'
}

{ #category : #initialization }
BlDevScripterInteractionStep >> initialize [
	super initialize.
	
	self onSelf
]
