Extension { #name : #BlTktCommandTask }

{ #category : #'*BlocPac-Tasker' }
BlTktCommandTask >> gtBlockClosureFor: aView [
	<gtView>
	^ self command
		ifNil: [ aView empty ] 
		ifNotNil: [ :aValuable | aValuable gtBlockClosureFor: aView ]
]

{ #category : #'*BlocPac-Tasker' }
BlTktCommandTask >> gtDecoratedCommandsFor: aView [
	<gtView>
	^ self command 
		ifNil: [ aView empty ]
		ifNotNil: [ :aCommand | aCommand gtDecoratedCommandsFor: aView ]
]
