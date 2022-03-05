"
If I am used, a {{gtClass:BlAsyncElement}} instance is updated when attached to a scene (it can still be invisible to a user).
To use me, call {{gtMethod:BlAsyncElement>>#updateWhenInScene}}.

"
Class {
	#name : #BlUpdateWhenInSceneStrategy,
	#superclass : #BlAsyncElementUpdateStrategy,
	#category : #'BlocPac-AsyncElement'
}

{ #category : #testing }
BlUpdateWhenInSceneStrategy >> needsUpdate: anAsyncElement [
	<return: #Boolean>
	^ anAsyncElement isAlreadyUpdated not and: [ anAsyncElement isAttachedToSceneGraph ]
]
