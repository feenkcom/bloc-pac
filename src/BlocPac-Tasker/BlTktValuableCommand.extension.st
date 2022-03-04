Extension { #name : #BlTktValuableCommand }

{ #category : #'*BlocPac-Tasker' }
BlTktValuableCommand >> gtBlockClosureFor: aView [
	<gtView>
	^ self valuable
		ifNil: [ aView empty ] 
		ifNotNil: [ :aValuable |
			aValuable isClosure
				ifTrue: [ aValuable gtSourceCodeFor: aView ]
				ifFalse: [ aView empty ] ]
]
