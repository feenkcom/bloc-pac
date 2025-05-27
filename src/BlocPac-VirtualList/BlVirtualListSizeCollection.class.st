Class {
	#name : #BlVirtualListSizeCollection,
	#superclass : #Object,
	#instVars : [
		'intervals',
		'count'
	],
	#category : #'BlocPac-VirtualList'
}

{ #category : #accessing }
BlVirtualListSizeCollection >> averageSize [
	| tot cnt |
	tot := 0.
	cnt := 0.
	intervals
		do: [ :each | 
			cnt := cnt + each count.
			tot := tot + each totalSize ].
	^ tot / cnt
]

{ #category : #accessing }
BlVirtualListSizeCollection >> count [
	^count
]

{ #category : #accessing }
BlVirtualListSizeCollection >> count: anObject [
	count := anObject
]

{ #category : #accessing }
BlVirtualListSizeCollection >> from: startIndex to: endIndex size: aNumber [
	| cnt |
	cnt := endIndex - startIndex + 1.
	intervals
		add: (BlVirtualListSizeInterval index: startIndex count: cnt elementSize: aNumber).
	count := count max: endIndex.
]

{ #category : #accessing }
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

{ #category : #accessing }
BlVirtualListSizeCollection >> initialize [
	super initialize.
	intervals := SortedCollection sortBlock: [:a :b | a index < b index].
	count := 0.
]

{ #category : #accessing }
BlVirtualListSizeCollection >> sizeUpTo: anInteger [
	| lastIndex totalSize avg stream each |
	lastIndex := 0.
	totalSize := 0.
	avg := self averageSize.
	stream := intervals readStream.
	[ stream atEnd not and: [ stream peek lastIndex < anInteger ] ]
		whileTrue: [ each := stream next.
			totalSize := totalSize + ((each index - (lastIndex + 1)) * avg).	"add unknown sizes"
			lastIndex := each lastIndex.
			totalSize := totalSize + each totalSize ].
	(stream atEnd
		or: [ each := stream next.
			anInteger < each index ])
		ifTrue: [ totalSize := totalSize + ((anInteger - lastIndex) * avg) ]
		ifFalse: [ totalSize := totalSize + ((each index - (lastIndex + 1)) * avg).
			totalSize := totalSize + ((anInteger - each index + 1) * each elementSize) ].
	^ totalSize
]

{ #category : #accessing }
BlVirtualListSizeCollection >> totalSize [
	^ self sizeUpTo: self count
]
