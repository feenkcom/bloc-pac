Extension { #name : #TKTWorkerProcess }

{ #category : #'*BlocPac-Tasker' }
TKTWorkerProcess >> entryIdentifier [ 

	^currentTaskExecution entryIdentifier
]

{ #category : #'*BlocPac-Tasker' }
TKTWorkerProcess >> isSuspended [

	^process isSuspended
]

{ #category : #'*BlocPac-Tasker' }
TKTWorkerProcess >> taskName [

	^currentTaskExecution
		ifNil: [ '<no task>' ]
		ifNotNil: [ currentTaskExecution name ]
]
