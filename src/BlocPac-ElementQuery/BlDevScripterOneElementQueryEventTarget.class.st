Class {
	#name : #BlDevScripterOneElementQueryEventTarget,
	#superclass : #BlScripterElementTarget,
	#traits : 'TBlElementQuery',
	#classTraits : 'TBlElementQuery classTrait',
	#instVars : [
		'query'
	],
	#category : #'BlocPac-ElementQuery-Scripter'
}

{ #category : #searching }
BlDevScripterOneElementQueryEventTarget >> findTargetIn: anElementOrCollectionOfElements [
	<return: #BlElement>
	| aResult allResults|
	
	aResult := anElementOrCollectionOfElements isCollection
		ifTrue: [ query findManyFromAll: anElementOrCollectionOfElements ]
		ifFalse: [ query findMany: anElementOrCollectionOfElements ].

	aResult hasResult
		ifFalse: [ AssertionFailure signal: 'Could not find an element for ', query printString ].

	allResults := aResult lastResult all.
	^ allResults size = 1
		ifTrue: [ allResults anyOne ]
		ifFalse: [ allResults ]
]

{ #category : #initialization }
BlDevScripterOneElementQueryEventTarget >> initialize [
	super initialize.
	
	query := BlElementLazyQuery new
]

{ #category : #accessing }
BlDevScripterOneElementQueryEventTarget >> queryStep: aBlElementStep [
	query queryStep: aBlElementStep
]
