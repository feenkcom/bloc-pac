Class {
	#name : #BlTktCommonQueueWorkerPool,
	#superclass : #TKTCommonQueueWorkerPool,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'processPriority'
	],
	#category : #'BlocPac-Tasker-Workers'
}

{ #category : #'public - mutexed' }
BlTktCommonQueueWorkerPool >> ensureIsWorking [
	"Over-write to not terminate worker processes.
	Trying to terminate idle workers produces more delays than resource saving."

	mutex
		critical: [ (workers reject: #isRunning)
				do: [ :worker | 
					BlTaskItTaskExecutionSignal
						emitValuable: worker currentTaskExecution
						message: 'Moved not running task to failed queue'.
					failedTasks add: worker currentTaskExecution.
					workers remove: worker ].
			(workers select: #isSuspended)
				do: [ :worker | 
					BlTaskItTaskExecutionSignal
						emitValuable: worker currentTaskExecution
						message: 'Moved suspended task to failed queue'.
					failedTasks add: worker currentTaskExecution.
					worker stopAfterTaskCompleted.
					workers remove: worker ].
			failedTasks
				ifNotEmpty: [ self
						traceCr: failedTasks size asString , ' Failed tasks encountered' ].
			self privateManageWorkersBefore.
			self privateManageWorkersAfter ]
]

{ #category : #schedulling }
BlTktCommonQueueWorkerPool >> future: aTask [
	<return: #TKTFuture>
	^ self withConfigurationDo: [ super future: aTask ].
]

{ #category : #initialization }
BlTktCommonQueueWorkerPool >> initialize [
	super initialize.
	processPriority := Processor userSchedulingPriority.
]

{ #category : #'public - mutexed' }
BlTktCommonQueueWorkerPool >> printOn: aStream [
	name ifNil: [ aStream nextPutAll: 'a '; nextPutAll: self className. ^ self ].
	aStream nextPutAll: name
]

{ #category : #private }
BlTktCommonQueueWorkerPool >> privateManageWorkersAfter [
	"Trying to terminate idle workers produces more delays than resource saving.
	Only create a worker if required (workers are light-weight anyway)"
	| free |

	free := self privateFreeWorkers.
	taskQueue size > free size
		ifTrue: [ self privateSpawnWorkerIfNeeded ]
]

{ #category : #private }
BlTktCommonQueueWorkerPool >> privateNewWorker [
	workers
		add:
			(TKTWorker new
				name: self name , ' Worker #' , (self size + 1) asString;
				taskQueue: taskQueue;
				processPriority: processPriority;
				start)
]

{ #category : #private }
BlTktCommonQueueWorkerPool >> privateRemoveIdleWorkerIfNeeded [
	"Trying to terminate idle workers produces more delays than resource saving.
	Leave workers waiting on the queue (they're light-weight anyway)"
]

{ #category : #accessing }
BlTktCommonQueueWorkerPool >> processPriority [
	<return: #Integer>
	^ processPriority
]

{ #category : #accessing }
BlTktCommonQueueWorkerPool >> processPriority: anInteger [
	self 
		assert: [ anInteger isInteger and: [ anInteger > 0 ] ]
		description: [ 'Worker process priority must be a positive integer' ].
	processPriority := anInteger
]

{ #category : #accessing }
BlTktCommonQueueWorkerPool >> processProvider [
	<return: #TKTTaskItProcessProvider>
	^ BlTktProcessProvider new processPriority: self processPriority
]

{ #category : #schedulling }
BlTktCommonQueueWorkerPool >> schedule: aTask [
	self withConfigurationDo: [ super schedule: aTask ].
]

{ #category : #schedulling }
BlTktCommonQueueWorkerPool >> schedule: aTask timeout: aTimeout [
	self withConfigurationDo: [ super schedule: aTask timeout: aTimeout ].
]

{ #category : #'public - mutexed' }
BlTktCommonQueueWorkerPool >> scheduleTaskExecution: aTaskExecution [

	| add |
	mutex critical: [ 
		self ensureIsBeingWatched.
		self privateManageWorkersBefore.
		"Don't schedule the task if it is already being executed"
		add := true.
		aTaskExecution entryIdentifier ifNotNil: [ :identifier |
			workers
				detect: [ :each | each entryIdentifier = identifier ] 
				ifFound: [ :entry |
					self flag: #remove.
					StringSignal emit: 'worker duplicate found'.
					add := false ] ].
		add ifTrue: [ taskQueue nextPut: aTaskExecution ].
		self privateManageWorkersAfter ]
]

{ #category : #'public - mutexed' }
BlTktCommonQueueWorkerPool >> start [ 
	"Bloc uses a pool of existing runners, rather than creating a new one on demand.
	Only start if not already started."

	^dog ifNil: [ super start ]
]

{ #category : #private }
BlTktCommonQueueWorkerPool >> withConfigurationDo: aBlock [
	^ TKTConfiguration 
		processProvider: self processProvider 
		during: aBlock
]
