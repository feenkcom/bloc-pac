Class {
	#name : #BlTktResponsiveCommand,
	#superclass : #BlTktValuableCommand,
	#instVars : [
		'request'
	],
	#category : 'BlocPac-Tasker-Commands'
}

{ #category : #taskit }
BlTktResponsiveCommand >> canHandleTerminationRequest [
	<return: #Boolean>
	^ true
]

{ #category : #defaults }
BlTktResponsiveCommand >> defaultValuable [
	^ [ :aBlTktRequest | 
			"do nothing, en example how to use the request variable"
			aBlTktRequest shouldTerminate 
				ifTrue: [ 'terminated' ] 
				ifFalse: [ aBlTktRequest terminate. 'executing' ] ]
]

{ #category : #evaluating }
BlTktResponsiveCommand >> execute [
	"execute command and return a result"
	<return: #Object>
	^ self valuable value: request.
]

{ #category : #testing }
BlTktResponsiveCommand >> includesTerminableCommand [
	<return: #Boolean>
	^ true
]

{ #category : #initialization }
BlTktResponsiveCommand >> initialize [
	super initialize.
	request := BlTktRequest new.
]

{ #category : #taskit }
BlTktResponsiveCommand >> terminate [
	request terminate
]

{ #category : #taskit }
BlTktResponsiveCommand >> terminateWithReason: aReason [
	request terminate
]
