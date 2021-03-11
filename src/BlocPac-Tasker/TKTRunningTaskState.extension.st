Extension { #name : #TKTRunningTaskState }

{ #category : #'*BlocPac-Tasker' }
TKTRunningTaskState >> terminateTaskExecution: aTaskExecution reason: aReason [

	| cancelState taskProcess activeContext timeoutContext |

	taskProcess := aTaskExecution executionProcess.
	"#isSuspended may be too broad, ideally we should have something like #isBeingDebugged.
	The suspended check prevents errors when terminating a task that is debugged or suspended due to an exception.
	See https://github.com/feenkcom/gtoolkit/issues/1823"
	taskProcess isSuspended
		ifTrue: [ ^ self ].
	
	cancelState := BlTktExplicitlyTerminatedTaskState new reason: aReason.
	
	taskProcess == Processor activeProcess ifTrue: [ 
		aTaskExecution setExplicitlyTerminatedStateWithReason: aReason.
		BlTaskItSelfTerminatedCommandSignal emitValuable: aTaskExecution task message: #selfTerminated.
		^cancelState signalExplicitlyTerminatedException. ].

	taskProcess suspend.	
	activeContext := taskProcess suspendedContext.
	timeoutContext := [ cancelState signalExplicitlyTerminatedException ] asContext.
	timeoutContext privSender: activeContext.
	taskProcess suspendedContext: timeoutContext.
	aTaskExecution setExplicitlyTerminatedStateWithReason: aReason.
	taskProcess priority: (Processor lowIOPriority min: taskProcess priority + 5).
	taskProcess resume.
	BlTaskItInjectedTerminationCommandSignal emitValuable: aTaskExecution task message: #terminationInjected.
]
