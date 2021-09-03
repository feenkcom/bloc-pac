Extension { #name : 'SharedQueue' }

{ #category : '*BlocPac-Tasker' }
SharedQueue >> itemArray [
	^ monitor critical: [ items asArray ]
]
