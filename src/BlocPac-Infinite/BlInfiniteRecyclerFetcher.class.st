Class {
	#name : #BlInfiniteRecyclerFetcher,
	#superclass : #Object,
	#instVars : [
		'nextFetcher'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'BlocPac-Infinite-Recycler'
}

{ #category : #cleanup }
BlInfiniteRecyclerFetcher class >> cleanUp [
	super cleanUp.
	
	instance := nil
]

{ #category : #accessing }
BlInfiniteRecyclerFetcher class >> instance [
	^ instance ifNil: [ instance := self new ]
]

{ #category : #initialization }
BlInfiniteRecyclerFetcher >> defaultNext [
	^ self subclassResponsibility
]

{ #category : #'element fetching' }
BlInfiniteRecyclerFetcher >> doFetchElementHolderFor: aFetcherContext [
	
]

{ #category : #'element fetching' }
BlInfiniteRecyclerFetcher >> elementHolderFor: aFetcherContext [
	"Try to find an element holder for a given layout position.
	aFetcherContext is a {{gtClass:BlInfiniteRecyclerFetcherContext}}"
	<return: #BlInfiniteRecyclerFetcherResult>
	| currentFetcher |
	
	aFetcherContext shouldLog
		ifTrue: [ aFetcherContext result: BlInfiniteRecyclerFetcherLoggingResult new ]
		ifFalse: [ aFetcherContext result: BlInfiniteRecyclerFetcherResult new ].

	currentFetcher := self.
	[
		aFetcherContext recordFetcher: currentFetcher.
		BlFrameTelemetry
			timeSync: [ 'Fetch element holder using {1}' format: { currentFetcher class name }  ]
			during: [ currentFetcher doFetchElementHolderFor: aFetcherContext ].
		currentFetcher := currentFetcher next ]
			doWhileTrue: [ aFetcherContext hasHolder not and: [ currentFetcher notNil ] ].

	^ aFetcherContext takeResult
]

{ #category : #'as yet unclassified' }
BlInfiniteRecyclerFetcher >> gtFetchersFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Fetchers';
		priority: 5;
		painting: [ :aMondrian | self gtPaintFetchersWith: aMondrian ]
]

{ #category : #'as yet unclassified' }
BlInfiniteRecyclerFetcher >> gtPaintFetchersWith: aMondrian [
	aMondrian nodes
		shape: [ :each |
			BrFrame new
				fitContent;
				addChild: (BrLabel new
					aptitude: BrGlamorousLabelAptitude;
					text: each class name);
				zIndex: 10 ];
		with: (self withDeepCollect: [ :aFetcher |
			aFetcher next
				ifNil: [ #() ]
				ifNotNil: [ :aNextFetcher | { aNextFetcher } ] ]).

	aMondrian edges
		fromNearestBounds;
		toNearestBounds;
		shape: [ :each |
			BlLineElement new
				toHead: (BlArrowheadSimpleArrow new border: (BlBorder paint: (Color gray alpha: 0.5) width: 10));
				border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: [ :each | each next
				ifNil: [ #() ]
				ifNotNil: [ :aNextFetcher | { aNextFetcher } ] ].

	aMondrian layout tree 
		nodeDistance: 10;
		levelDistance: 20
]

{ #category : #accessing }
BlInfiniteRecyclerFetcher >> hasNext [
	^ nextFetcher notNil
]

{ #category : #initialization }
BlInfiniteRecyclerFetcher >> initialize [
	super initialize.
	
	nextFetcher := self defaultNext
]

{ #category : #accessing }
BlInfiniteRecyclerFetcher >> next [
	^ nextFetcher
]

{ #category : #accessing }
BlInfiniteRecyclerFetcher >> next: aRecyclerFetcher [
	nextFetcher := aRecyclerFetcher
]

{ #category : #accessing }
BlInfiniteRecyclerFetcher >> nextDo: aBlock [
	^ self next ifNotNil: aBlock
]
