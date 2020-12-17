Extension { #name : #TKTCommonQueueWorkerPool }

{ #category : #'*BlocPac-Tasker' }
TKTCommonQueueWorkerPool >> finalize [ 

	self stop.
	super finalize.

]

{ #category : #'*BlocPac-Tasker' }
TKTCommonQueueWorkerPool >> gtWorkersFor: aView [
	<gtView>
	self workers ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Workers';
		items: [ self workers asOrderedCollection ];
		column: 'Name' item: [ :aWorker | aWorker name ];
		column: 'Has Task' item: [ :aWorker | aWorker isFree not ] width: 80;
		column: 'Is Running' item: [ :aWorker | aWorker isRunning ] width: 80
]

{ #category : #'*BlocPac-Tasker' }
TKTCommonQueueWorkerPool >> isFree [
	<return: #Boolean>
	^ taskQueue isEmpty and: [ workers allSatisfy: [ :each | each isFree ] ]
]

{ #category : #'*BlocPac-Tasker' }
TKTCommonQueueWorkerPool >> killWatchDog [
	dog ifNotNil: [ :aWatchDog | aWatchDog kill ]
]

{ #category : #'*BlocPac-Tasker' }
TKTCommonQueueWorkerPool >> numberOfFailedTasks [
	<return: #Integer>
	^ failedTasks ifNotNil: #size ifNil: 0
]

{ #category : #'*BlocPac-Tasker' }
TKTCommonQueueWorkerPool >> poolMaxSize [

	^poolMaxSize
]

{ #category : #'*BlocPac-Tasker' }
TKTCommonQueueWorkerPool >> taskQueue [ 

	^taskQueue
]
