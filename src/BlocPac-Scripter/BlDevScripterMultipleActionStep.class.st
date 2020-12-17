Class {
	#name : #BlDevScripterMultipleActionStep,
	#superclass : #BlDevScripterCompositeStep,
	#traits : 'TBlDevScripterActionStep + (TBlDevScripterCheckStepCreation - {#addStep:})',
	#classTraits : 'TBlDevScripterActionStep classTrait + TBlDevScripterCheckStepCreation classTrait',
	#category : #'BlocPac-Scripter-Scripter-Steps'
}
