Class {
	#name : #BlDevScripterStepExecutorSyncStrategy,
	#superclass : #BlDevScripterStepExecutorStrategy,
	#category : #'BlocPac-Scripter-Scripter-Executors'
}

{ #category : #execution }
BlDevScripterStepExecutorSyncStrategy >> startOnScripter: aScripter executor: anExecutor [
	BlUseAsyncFeatures disableDuring: [ 
		super startOnScripter: aScripter executor: anExecutor ]
]
