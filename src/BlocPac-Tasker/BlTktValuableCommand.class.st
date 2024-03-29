Class {
	#name : #BlTktValuableCommand,
	#superclass : #BlTktCommand,
	#instVars : [
		'valuable'
	],
	#category : #'BlocPac-Tasker-Commands'
}

{ #category : #defaults }
BlTktValuableCommand >> defaultValuable [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTktValuableCommand >> entryIdentifier [
	"Answer the identity of the receiver for task scheduling.
	Defer to my valuable."
	
	^ valuable entryIdentifier
]

{ #category : #accessing }
BlTktValuableCommand >> entryPriority [

	^ valuable entryPriority
]

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

{ #category : #initialization }
BlTktValuableCommand >> initialize [
	super initialize.
	self valuable: self defaultValuable.
	
]

{ #category : #accessing }
BlTktValuableCommand >> valuable [
	^ valuable
]

{ #category : #accessing }
BlTktValuableCommand >> valuable: aValuable [
	self
		assert: [ aValuable isNotNil ] 
		description: [ 'Valuable must be non-nil' ].

	valuable := aValuable
]
