Extension { #name : #BlockClosure }

{ #category : #'*BlocPac-Tasker' }
BlockClosure >> asBlTktCommand [
	<return: #BlTktValuableCommand>
	self numArgs = 0 ifTrue: [ ^ BlTktUnresponsiveCommand new valuable: self; name: 'BlockClosure without arguments' ].
	self numArgs = 1 ifTrue: [ ^ BlTktResponsiveCommand new valuable: self; name: 'BlockClosure with 1 argument' ].
	self error: 'BlockClosure must have zero or one argument'
]

{ #category : #'*BlocPac-Tasker' }
BlockClosure >> asBlTktTerminableCommand [
	^ BlTktTerminableCommand new command: self asBlTktCommand
]
