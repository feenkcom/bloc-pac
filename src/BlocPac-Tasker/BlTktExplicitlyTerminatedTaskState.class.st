Class {
	#name : #BlTktExplicitlyTerminatedTaskState,
	#superclass : #BlTktCommandTaskState,
	#instVars : [
		'reason'
	],
	#category : 'BlocPac-Tasker-TaskIt Tasks'
}

{ #category : #cancelling }
BlTktExplicitlyTerminatedTaskState >> cancelTaskExecution: aTaskExecution reason: aReason [
	"do nothing"
]

{ #category : #testing }
BlTktExplicitlyTerminatedTaskState >> isFinished [
	^ true
]

{ #category : #executing }
BlTktExplicitlyTerminatedTaskState >> performTaskExecution: aTaskExecution [
	"do nothing"
	^ nil
]

{ #category : #accessing }
BlTktExplicitlyTerminatedTaskState >> reason [
	<return: #String>
	^ reason
]

{ #category : #accessing }
BlTktExplicitlyTerminatedTaskState >> reason: aString [
	self 
		assert: [ aString isNotNil ]
		description: [ 'Reason must be non-nil' ].
	reason := aString
]

{ #category : #signalling }
BlTktExplicitlyTerminatedTaskState >> signalExplicitlyTerminatedException [

	BlTktExplicitlyTerminatedTaskException signal: reason
]

{ #category : #cancelling }
BlTktExplicitlyTerminatedTaskState >> terminateTaskExecution: aTaskExecution reason: aReason [
	"do nothing"
]
