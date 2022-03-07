Extension { #name : #BlTktDecoratedCommand }

{ #category : #'*BlocPac-Tasker' }
BlTktDecoratedCommand >> gtDecoratedCommands [
	<return: #Array of: #BlTktProtoCommand>
	^ Array streamContents: [ :aStream | 
		self putDecoratedCommandInto: aStream ]
]

{ #category : #'*BlocPac-Tasker' }
BlTktDecoratedCommand >> gtDecoratedCommandsFor: aView [
	<gtView>
	self command ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Commands';
		items: [ self gtDecoratedCommands ]
]

{ #category : #'*BlocPac-Tasker' }
BlTktDecoratedCommand >> putDecoratedCommandInto: aStream [
	self command ifNil: [ ^ self ].
	aStream nextPut: self command.
	self command putDecoratedCommandInto: aStream.
]
