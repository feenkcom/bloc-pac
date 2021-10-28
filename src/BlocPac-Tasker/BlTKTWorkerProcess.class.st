Class {
	#name : #BlTKTWorkerProcess,
	#superclass : #TKTWorkerProcess,
	#instVars : [
		'processTasks'
	],
	#category : 'BlocPac-Tasker-Processes'
}

{ #category : #initialization }
BlTKTWorkerProcess >> initialize [ 

	super initialize.
	processTasks := true.
]

{ #category : #'start-stop' }
BlTKTWorkerProcess >> stopAfterTaskCompleted [
	"Stop after the current task has been completed"

	processTasks := false.
]

{ #category : #'start-stop' }
BlTKTWorkerProcess >> workerLoop [
	"Execute tasks until asked to stop"

	[ processTasks ] whileTrue:
		[ self executeTask: taskQueue next ]
]
