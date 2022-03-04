Class {
	#name : #BlElementTask,
	#superclass : #BlTask,
	#instVars : [
		'promise'
	],
	#category : #'BlocPac-Tasker-Element Tasks'
}

{ #category : #accessing }
BlElementTask >> future [
	^ promise
]

{ #category : #accessing }
BlElementTask >> future: anObject [
	promise := anObject
]
