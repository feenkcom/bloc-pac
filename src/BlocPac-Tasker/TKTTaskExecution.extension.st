Extension { #name : 'TKTTaskExecution' }

{ #category : '*BlocPac-Tasker' }
TKTTaskExecution >> entryIdentifier [
	"Answer the queue entry identifier of the receiver when submitted as a task to TaskIt."

	^ task entryIdentifier
]

{ #category : '*BlocPac-Tasker' }
TKTTaskExecution >> entryPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^ task entryPriority
]

{ #category : '*BlocPac-Tasker' }
TKTTaskExecution >> executionProcess: aProcess [
	"For testing purpose only"
	executionProcess := aProcess
]

{ #category : '*BlocPac-Tasker' }
TKTTaskExecution >> name [ 
	<return: #String>
	^ task name
]

{ #category : '*BlocPac-Tasker' }
TKTTaskExecution >> setExplicitlyTerminatedStateWithReason: aReason [
	state := BlTktExplicitlyTerminatedTaskState new reason: aReason
]

{ #category : '*BlocPac-Tasker' }
TKTTaskExecution >> state [
	"For testing purpose only."
	<return: #TKTTaskState>
	^ state
]

{ #category : '*BlocPac-Tasker' }
TKTTaskExecution >> task [ 
	<return: #TKTTask>
	^ task
]

{ #category : '*BlocPac-Tasker' }
TKTTaskExecution >> terminateWithReason: aReason [
	state terminateTaskExecution: self reason: aReason
]
