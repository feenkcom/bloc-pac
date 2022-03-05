"
If I am used, a {{gtClass:BlAsyncElement}} instance is updated when visible on the screen.
To use me, call {{gtMethod:BlAsyncElement>>#updateWhenVisible}}.

"
Class {
	#name : #BlUpdateWhenVisibleStrategy,
	#superclass : #BlAsyncElementUpdateStrategy,
	#category : #'BlocPac-AsyncElement'
}

{ #category : #testing }
BlUpdateWhenVisibleStrategy >> needsUpdate: anAsyncElement [
	<return: #Boolean>
	^ anAsyncElement isAlreadyUpdated not and: [ 
		anAsyncElement isVisibleInSpace and: [
		 anAsyncElement isLayoutRequested not ] ]
]
