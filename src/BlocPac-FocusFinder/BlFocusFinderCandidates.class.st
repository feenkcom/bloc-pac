Class {
	#name : #BlFocusFinderCandidates,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'candidates'
	],
	#category : #'BlocPac-FocusFinder-Core'
}

{ #category : #adding }
BlFocusFinderCandidates >> add: anElement [
	candidates add: anElement
]

{ #category : #accessing }
BlFocusFinderCandidates >> at: anIndex [
	^ candidates at: anIndex
]

{ #category : #enumerating }
BlFocusFinderCandidates >> do: aBlock [
	candidates do: aBlock
]

{ #category : #accessing }
BlFocusFinderCandidates >> indexOf: anElement ifAbsent: exceptionBlock [
	^ candidates indexOf: anElement ifAbsent: exceptionBlock
]

{ #category : #initialization }
BlFocusFinderCandidates >> initialize [
	super initialize.
	
	candidates := OrderedCollection new
]

{ #category : #testing }
BlFocusFinderCandidates >> isEmpty [
	<return: #Boolean>

	^ self size isZero
]

{ #category : #accessing }
BlFocusFinderCandidates >> size [
	<return: #Number>
	
	^ candidates size
]
