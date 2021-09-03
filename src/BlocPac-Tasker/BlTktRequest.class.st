Class {
	#name : 'BlTktRequest',
	#superclass : 'Object',
	#instVars : [
		'terminate'
	],
	#category : 'BlocPac-Tasker-Commands'
}

{ #category : 'initialization' }
BlTktRequest >> initialize [
	super initialize.
	terminate := false.
]

{ #category : 'testing' }
BlTktRequest >> shouldTerminate [
	<return: #Boolean>
	^ terminate
]

{ #category : 'requests' }
BlTktRequest >> terminate [
	terminate := true
]
