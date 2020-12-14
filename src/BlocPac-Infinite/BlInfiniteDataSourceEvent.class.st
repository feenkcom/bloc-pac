Class {
	#name : #BlInfiniteDataSourceEvent,
	#superclass : #BlEvent,
	#instVars : [
		'dataSource'
	],
	#category : #'BlocPac-Infinite-Events'
}

{ #category : #accessing }
BlInfiniteDataSourceEvent >> dataSource [
	^ dataSource
]

{ #category : #accessing }
BlInfiniteDataSourceEvent >> dataSource: anObject [
	dataSource := anObject
]
