Class {
	#name : #BlVirtualListSizeInterval,
	#superclass : #Object,
	#instVars : [
		'index',
		'count',
		'elementSize'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #accessing }
BlVirtualListSizeInterval class >> index: startIndex count: cnt elementSize: aNumber [
	^ self new
		index: startIndex;
		count: cnt;
		elementSize: aNumber;
		yourself
]

{ #category : #accessing }
BlVirtualListSizeInterval >> count [
	^ count
]

{ #category : #accessing }
BlVirtualListSizeInterval >> count: cnt [
	count := cnt 
]

{ #category : #accessing }
BlVirtualListSizeInterval >> elementSize [
	^ elementSize
]

{ #category : #accessing }
BlVirtualListSizeInterval >> elementSize: aNumber [
	elementSize := aNumber
]

{ #category : #accessing }
BlVirtualListSizeInterval >> index [
	^ index
]

{ #category : #accessing }
BlVirtualListSizeInterval >> index: startIndex [
	index := startIndex
]

{ #category : #accessing }
BlVirtualListSizeInterval >> lastIndex [
	^index + count - 1
]

{ #category : #'as yet unclassified' }
BlVirtualListSizeInterval >> printOn: aStream [
	aStream nextPut: $[.
	index printOn: aStream.
	aStream nextPut: $,.
	count printOn: aStream.
	aStream nextPut: $,.
	elementSize printOn: aStream.
	aStream nextPut: $]
]

{ #category : #accessing }
BlVirtualListSizeInterval >> totalSize [
	^ self count * self elementSize
]
