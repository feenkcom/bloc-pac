Class {
	#name : #BlDevScripterStepFailureState,
	#superclass : #BlDevScripterStepState,
	#category : #'BlocPac-Scripter-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepFailureState >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
BlDevScripterStepFailureState >> name [
	^ 'failed'
]

{ #category : #testing }
BlDevScripterStepFailureState >> wasExecuted [
	<return: #Boolean>
	^ true
]
