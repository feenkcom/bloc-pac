Extension { #name : 'TKTReadyTaskState' }

{ #category : '*BlocPac-Tasker' }
TKTReadyTaskState >> terminateTaskExecution: aTaskExecution reason: aReason [

	aTaskExecution setExplicitlyTerminatedStateWithReason: aReason
]
