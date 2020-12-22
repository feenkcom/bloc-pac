Extension { #name : #AtomicSharedQueue }

{ #category : #'*BlocPac-Tasker' }
AtomicSharedQueue >> contents [ 
	"Answer all objects.
	Provided for compatibility with SharedPriorityUniqueQueue"

	^(self itemArray
		reject: [ :each | each isZombie ])
			collect: [ :item | item object ].

]
