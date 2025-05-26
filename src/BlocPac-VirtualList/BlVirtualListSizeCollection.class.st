Class {
	#name : #BlVirtualListSizeCollection,
	#superclass : #Object,
	#instVars : [
		'intervals',
		'count'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #'as yet unclassified' }
BlVirtualListSizeCollection >> averageSize [
	| tot cnt |
	tot := 0.
	cnt := 0.
	intervals
		do: [ :each | 
			cnt := cnt + each second.
			tot := tot + (each second * each third) ].
	^ tot / cnt
]

{ #category : #'as yet unclassified' }
BlVirtualListSizeCollection >> count [
	^count
]

{ #category : #accessing }
BlVirtualListSizeCollection >> count: anObject [
	count := anObject
]

{ #category : #'as yet unclassified' }
BlVirtualListSizeCollection >> from: startIndex to: endIndex size: aNumber [
	| cnt |
	cnt := endIndex - startIndex + 1.
	intervals
		add: {startIndex.
				cnt.
				aNumber}.
	count := count max: endIndex.
]

{ #category : #views }
BlVirtualListSizeCollection >> gtDetailsViewFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		items: [ {'count' -> self count.
				'totalSize' -> self totalSize.
				'averageSize' -> self averageSize} ];
		column: 'Key' text: [ :each | each key gtDisplayString ];
		column: 'Value' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ]
]

{ #category : #'as yet unclassified' }
BlVirtualListSizeCollection >> initialize [
	super initialize.
	intervals := SortedCollection sortBlock: [:a :b | a first < b first].
	count := 0.
]

{ #category : #'as yet unclassified' }
BlVirtualListSizeCollection >> totalSize [
	| lastIndex totalSize avg |
	lastIndex := 0.
	totalSize := 0.
	avg := self averageSize.
	intervals
		do: [ :each | 
			totalSize := totalSize + ((each first - (lastIndex + 1)) * avg).
			lastIndex := (each first + each second - 1).
			totalSize := totalSize + (each second * each third) ].
	totalSize := totalSize + ((count - lastIndex) * avg).
	^ totalSize
]
