"
BlLocalImageCacheTestEntry acts as a proxy for {{gtClass:name=BlAsyncImageElement}} during testing.


"
Class {
	#name : #BlImageCacheTestEntry,
	#superclass : #Object,
	#instVars : [
		'entry'
	],
	#category : #'BlocPac-Imager-Examples-Tests'
}

{ #category : #accessing }
BlImageCacheTestEntry >> entry [
	^ entry
]

{ #category : #accessing }
BlImageCacheTestEntry >> entry: anObject [
	entry := anObject
]
