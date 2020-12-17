Class {
	#name : #BlDevScripterStepContinueExecutor,
	#superclass : #BlDevScripterStepExecutor,
	#category : #'BlocPac-Scripter-Scripter-Executors'
}

{ #category : #testing }
BlDevScripterStepContinueExecutor >> canBeExecuted: aStep [
	<return: #Boolean>
	^ aStep wasExecuted not
]
