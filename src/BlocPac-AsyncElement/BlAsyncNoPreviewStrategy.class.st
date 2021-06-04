"
I do not generate any preview. 
I am a default {{gtClass:BlAsyncElement}} preview strategy set in the {{gtMethod:BlAsyncElement>>#defaultPreviewStrategy}} method.


"
Class {
	#name : #BlAsyncNoPreviewStrategy,
	#superclass : #BlAsyncPreviewStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'BlocPac-AsyncElement'
}

{ #category : #cleanup }
BlAsyncNoPreviewStrategy class >> cleanUniqueInstance [
	uniqueInstance := nil
]

{ #category : #cleanup }
BlAsyncNoPreviewStrategy class >> cleanUp [
	self cleanUniqueInstance
]

{ #category : #cleanup }
BlAsyncNoPreviewStrategy class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
BlAsyncNoPreviewStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #scheduling }
BlAsyncNoPreviewStrategy >> schedulePreviewIn: anElement [
	"do nothing"
	
]
