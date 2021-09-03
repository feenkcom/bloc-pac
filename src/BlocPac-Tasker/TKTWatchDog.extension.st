Extension { #name : 'TKTWatchDog' }

{ #category : '*BlocPac-Tasker' }
TKTWatchDog >> hasPoolWorkerNamed: aString [
	^ self pool 
			ifNotNil: [ :aPool | aPool name = aString ]
			ifNil: [ false ]
]

{ #category : '*BlocPac-Tasker' }
TKTWatchDog >> numberOfFailedTasks [
	^ self pool 
			ifNotNil: [ :aPool | aPool numberOfFailedTasks ]
			ifNil: 0
]

{ #category : '*BlocPac-Tasker' }
TKTWatchDog >> taskQueueSize [
	^ self pool 
			ifNotNil: [ :aPool | aPool taskQueue size ]
			ifNil: 0
]
