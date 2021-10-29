Class {
	#name : #BlCommonParentLostEvent,
	#superclass : #BlEvent,
	#instVars : [
		'commonParent',
		'parentChain'
	],
	#category : #'BlocPac-CommonParent'
}

{ #category : #accessing }
BlCommonParentLostEvent >> commonParent [

	^ commonParent
]

{ #category : #accessing }
BlCommonParentLostEvent >> commonParent: anObject [

	commonParent := anObject
]

{ #category : #accessing }
BlCommonParentLostEvent >> parentChain [

	^ parentChain
]

{ #category : #accessing }
BlCommonParentLostEvent >> parentChain: anObject [

	parentChain := anObject
]

{ #category : #sending }
BlCommonParentLostEvent >> sendTo: anObject [
	^ anObject commonParentLostEvent: self
]
