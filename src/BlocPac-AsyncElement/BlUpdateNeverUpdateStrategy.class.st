"
If I am used, a {{gtClass:BlAsyncElement}} instance is never updated.
To use me, call {{gtMethod:BlAsyncElement>>#neverUpdate}}.
This is a special case, when an instance is updated differently.


"
Class {
	#name : #BlUpdateNeverUpdateStrategy,
	#superclass : #BlAsyncElementUpdateStrategy,
	#category : #'BlocPac-AsyncElement'
}

{ #category : #testing }
BlUpdateNeverUpdateStrategy >> needsUpdate: anAsyncElement [
	<return: #Boolean>
	^ false
]
