Extension { #name : #TKTGenericTask }

{ #category : #'*BlocPac-Tasker' }
TKTGenericTask >> entryIdentifier [
	"Answer the queue entry identifier of the receiver for task scheduling.
	Defer to my command."

	^valuable entryIdentifier
]

{ #category : #'*BlocPac-Tasker' }
TKTGenericTask >> entryPriority [ 
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^valuable entryPriority
]
