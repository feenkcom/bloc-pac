Class {
	#name : #BlDevScripterSecondaryClickStep,
	#superclass : #BlDevScripterInteractionStep,
	#category : #'BlocPac-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterSecondaryClickStep >> defaultLabel [
	^ 'Secondary Click'
]

{ #category : #actions }
BlDevScripterSecondaryClickStep >> playOn: aScripter [
	self
		setMousePosition: (BlSpace simulateSecondaryClickOn: (self target findTargetStartingInScripter: aScripter))
		in: aScripter.
	aScripter pulse
]
