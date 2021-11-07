Class {
	#name : #BlTktWithFinishCallbackCommand,
	#superclass : #BlTktDecoratedCommand,
	#instVars : [
		'callback'
	],
	#category : #'BlocPac-Tasker-Commands'
}

{ #category : #accessing }
BlTktWithFinishCallbackCommand >> command: aCommand [
	super command: aCommand asErrorCatchingCommand
]

{ #category : #evaluating }
BlTktWithFinishCallbackCommand >> execute [
	"execute command and return a result"
	<return: #Object>

	[ self command execute ]
		ensure: [ callback value ].
	
	^ self command result
]

{ #category : #accessing }
BlTktWithFinishCallbackCommand >> name [
	<return: #String>

	^ self command name
]

{ #category : #accessing }
BlTktWithFinishCallbackCommand >> onFinishedDo: anObject [
	callback := anObject
]
