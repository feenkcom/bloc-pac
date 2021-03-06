Class {
	#name : #BlExampleInfiniteForGeometryNode,
	#superclass : #Object,
	#instVars : [
		'nodes'
	],
	#category : #'BlocPac-Infinite-Examples'
}

{ #category : #adding }
BlExampleInfiniteForGeometryNode >> addNode: aNode [
	self nodes add: aNode
]

{ #category : #converting }
BlExampleInfiniteForGeometryNode >> asElement [
	^ self create
]

{ #category : #converting }
BlExampleInfiniteForGeometryNode >> create [
	^ self subclassResponsibility
]

{ #category : #initialization }
BlExampleInfiniteForGeometryNode >> initialize [
	super initialize.
	
	nodes := OrderedCollection new
]

{ #category : #accessing }
BlExampleInfiniteForGeometryNode >> nodes [
	^ nodes
]
