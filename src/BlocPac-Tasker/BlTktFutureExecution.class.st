Class {
	#name : #BlTktFutureExecution,
	#superclass : #TKTFutureExecution,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'BlocPac-Tasker-TaskIt Tasks'
}

{ #category : #evaluating }
BlTktFutureExecution >> doExecuteTask [

	timeout ifNotNil:
		[ TKTConfiguration runner scheduleTimeout: timeout on: self ].
	[ future deploySuccess: task value ]
		on: BlTktExplicitlyTerminatedTaskException, Error
		do: [ :error | future deployFailure: error freeze "freezeOrWithoutContext" ].

]
