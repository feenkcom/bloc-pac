Class {
	#name : #BlDevScripterStepExecutorStrategy,
	#superclass : #Object,
	#category : #'BlocPac-Scripter-Scripter-Executors'
}

{ #category : #execution }
BlDevScripterStepExecutorStrategy >> playStep: aStep executor: anExecutor [
	aStep playOnExecutor: anExecutor
]

{ #category : #execution }
BlDevScripterStepExecutorStrategy >> startOnScripter: aScripter executor: anExecutor [
	aScripter pulse.
	aScripter startWithExecutor: anExecutor.
	aScripter pulse.
]
