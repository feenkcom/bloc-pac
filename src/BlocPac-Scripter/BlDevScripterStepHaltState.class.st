Class {
	#name : #BlDevScripterStepHaltState,
	#superclass : #BlDevScripterStepState,
	#category : #'BlocPac-Scripter-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepHaltState >> color [
	<return: #Color>
	^ BrGlamorousColors failureBackgroundColor
]

{ #category : #testing }
BlDevScripterStepHaltState >> isHalt [
	^ true
]

{ #category : #accessing }
BlDevScripterStepHaltState >> name [
	<return: #String>
	^ 'halt'
]
