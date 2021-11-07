Class {
	#name : #BlWaitingLazyElementBuilderTask,
	#superclass : #BlTask,
	#instVars : [
		'isRunning'
	],
	#category : #'BlocPac-AsyncElement'
}

{ #category : #initialization }
BlWaitingLazyElementBuilderTask >> initialize [
	super initialize.
	
	isRunning := true
]

{ #category : #initialization }
BlWaitingLazyElementBuilderTask >> markAsFinished [
	isRunning := false
]

{ #category : #initialization }
BlWaitingLazyElementBuilderTask >> requeueTaskAfterExecution [
	"Answer a boolean indicating whether the receiver should be requeued after execution."

	^ isRunning
]

{ #category : #running }
BlWaitingLazyElementBuilderTask >> run [
]
