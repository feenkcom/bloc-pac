Class {
	#name : #BlDevScripterStepSuccessState,
	#superclass : #BlDevScripterStepState,
	#category : #'BlocPac-Scripter-Scripter-States'
}

{ #category : #accessing }
BlDevScripterStepSuccessState >> color [
	^ BrGlamorousColors successBackgroundColor
]

{ #category : #accessing }
BlDevScripterStepSuccessState >> name [
	^ 'success'
]

{ #category : #testing }
BlDevScripterStepSuccessState >> wasExecuted [
	<return: #Boolean>
	^ true
]
