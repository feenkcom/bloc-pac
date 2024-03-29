Class {
	#name : #BlTktProtoCommand,
	#superclass : #Object,
	#category : #'BlocPac-Tasker-Commands'
}

{ #category : #converting }
BlTktProtoCommand >> asBlTktCommand [
	^ self
]

{ #category : #converting }
BlTktProtoCommand >> asBlTktLoggingCommand [
	^ BlTktLoggingCommand command: self
]

{ #category : #converting }
BlTktProtoCommand >> asBlTktSingleCommand [
	^ BlTktSingleCommand new command: self
]

{ #category : #converting }
BlTktProtoCommand >> asBlTktTerminableCommand [
	^ BlTktTerminableCommand new command: self
]

{ #category : #converting }
BlTktProtoCommand >> asErrorCatchingCommand [
	<return: #BlErrorCatchingCommand>
	^ BlErrorCatchingCommand new command: self
]

{ #category : #converting }
BlTktProtoCommand >> asResultPreservingCommand [
	<return: #BlTktPreservingResultCommand>
	^ BlTktPreservingResultCommand new command: self
]

{ #category : #taskit }
BlTktProtoCommand >> asTask [
	<return: #BlTktCommandTask>
	^ BlTktCommandTask new command: self.
]

{ #category : #taskit }
BlTktProtoCommand >> canHandleTerminationRequest [
	<return: #Boolean>
	^ false
]

{ #category : #accessing }
BlTktProtoCommand >> entryPriority [
	"Answer the priority of the receiver for task scheduling."

	^1
]

{ #category : #evaluating }
BlTktProtoCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	^ self subclassResponsibility
]

{ #category : #taskit }
BlTktProtoCommand >> future [
	^ self futureInUIPool
]

{ #category : #taskit }
BlTktProtoCommand >> futureInPool: aWorkerPool [
	<return: #TKTFuture>
	^ aWorkerPool future: self
]

{ #category : #taskit }
BlTktProtoCommand >> futureInUIPool [
	^ self futureInPool: BlTktWorkerProvider highUICPUBoundPool
]

{ #category : #'*BlocPac-Tasker' }
BlTktProtoCommand >> gtBlockClosureFor: aView [
	^ aView empty
]

{ #category : #'*BlocPac-Tasker' }
BlTktProtoCommand >> gtDecoratedCommandsFor: aView [
	^ aView empty
]

{ #category : #testing }
BlTktProtoCommand >> includesLoggingCommand [
	<return: #Boolean>
	^ false
]

{ #category : #testing }
BlTktProtoCommand >> includesSingleCommand [
	<return: #Boolean>
	^ false
]

{ #category : #testing }
BlTktProtoCommand >> includesTerminableCommand [
	<return: #Boolean>
	^ false
]

{ #category : #accessing }
BlTktProtoCommand >> name [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTktProtoCommand >> name: aString [
	^ self subclassResponsibility
]

{ #category : #'*BlocPac-Tasker' }
BlTktProtoCommand >> putDecoratedCommandInto: aStream [
	"do nothing"
]

{ #category : #taskit }
BlTktProtoCommand >> schedule [
	^ self scheduleInUIPool
]

{ #category : #taskit }
BlTktProtoCommand >> scheduleInPool: aWorkerPool [
	<return: #TKTTask>
	| aTask |
	aTask := self asTask.
	aWorkerPool schedule: aTask.
	^ aTask
]

{ #category : #taskit }
BlTktProtoCommand >> scheduleInUIPool [
	<return: #TKTTask>
	^ self scheduleInPool: BlTktWorkerProvider highUICPUBoundPool.
]

{ #category : #taskit }
BlTktProtoCommand >> taskExecution: anExecution [
	"do nothing"
]

{ #category : #evaluating }
BlTktProtoCommand >> value [
	"execute command and return a result"
	<return: #Object>
	^ self execute
]
