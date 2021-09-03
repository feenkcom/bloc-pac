Extension { #name : 'TKTWorker' }

{ #category : '*BlocPac-Tasker' }
TKTWorker >> entryIdentifier [ 

	^process entryIdentifier 

]

{ #category : '*BlocPac-Tasker' }
TKTWorker >> isSuspended [

	^process isSuspended
]

{ #category : '*BlocPac-Tasker' }
TKTWorker >> stopAfterTaskCompleted [
	"Stop after the current task has been completed"

	^process stopAfterTaskCompleted

]

{ #category : '*BlocPac-Tasker' }
TKTWorker >> taskName [

	^process
		ifNil: [ '<no task>' ]
		ifNotNil: [ process taskName ]
]
