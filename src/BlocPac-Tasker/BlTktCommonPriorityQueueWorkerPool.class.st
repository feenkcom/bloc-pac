Class {
	#name : #BlTktCommonPriorityQueueWorkerPool,
	#superclass : #BlTktCommonQueueWorkerPool,
	#category : #'BlocPac-Tasker-Workers'
}

{ #category : #initialization }
BlTktCommonPriorityQueueWorkerPool >> initialize [ 
	super initialize.
	taskQueue := SharedPriorityUniqueQueue new.
]
