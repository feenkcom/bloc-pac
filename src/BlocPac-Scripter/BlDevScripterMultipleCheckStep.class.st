Class {
	#name : #BlDevScripterMultipleCheckStep,
	#superclass : #BlDevScripterCompositeStep,
	#traits : 'TBlDevScripterCheckStep + (TBlDevScripterCheckStepCreation - {#addStep:})',
	#classTraits : 'TBlDevScripterCheckStep classTrait + TBlDevScripterCheckStepCreation classTrait',
	#category : #'BlocPac-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> defaultLabel [
	^ 'Checks'
]
