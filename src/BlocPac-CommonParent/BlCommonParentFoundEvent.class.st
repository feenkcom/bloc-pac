Class {
	#name : #BlCommonParentFoundEvent,
	#superclass : #BlEvent,
	#instVars : [
		'commonParent',
		'parentChain'
	],
	#category : #'BlocPac-CommonParent'
}

{ #category : #accessing }
BlCommonParentFoundEvent >> commonParent [

	^ commonParent
]

{ #category : #accessing }
BlCommonParentFoundEvent >> commonParent: anObject [

	commonParent := anObject
]

{ #category : #accessing }
BlCommonParentFoundEvent >> parentChain [

	^ parentChain
]

{ #category : #accessing }
BlCommonParentFoundEvent >> parentChain: anObject [

	parentChain := anObject
]

{ #category : #sending }
BlCommonParentFoundEvent >> sendTo: anObject [
	^ anObject commonParentFoundEvent: self
]
