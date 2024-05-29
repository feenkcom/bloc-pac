Class {
	#name : #BlElementQueryByPropertySelector,
	#superclass : #BlElementQueryStep,
	#instVars : [
		'isDeep'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #'api - query' }
BlElementQueryByPropertySelector >> findElementsIn: aCurrentQueryResult andAddTo: aNewQueryResult [
	aCurrentQueryResult
		while: [ aNewQueryResult wantsMore ]
		do: [ :eachElement |
			| doesMatch |
			
			doesMatch := self matchesElement: eachElement.
			doesMatch
				ifTrue: [ aNewQueryResult addElement: eachElement ].
			"if eachElement matches the query, exclude its children from search"
			doesMatch not ]
		deep: self isDeep
]

{ #category : #initialization }
BlElementQueryByPropertySelector >> initialize [
	super initialize.
	
	isDeep := false
]

{ #category : #accessing }
BlElementQueryByPropertySelector >> isDeep [
	^ isDeep
]

{ #category : #accessing }
BlElementQueryByPropertySelector >> isDeep: anObject [
	isDeep := anObject
]

{ #category : #'api - query' }
BlElementQueryByPropertySelector >> matchesElement: anElement [
	^ self subclassResponsibility
]

{ #category : #printing }
BlElementQueryByPropertySelector >> printOn: aStream [
	self isDeep
		ifTrue: [ aStream nextPutAll: '//' ]
		ifFalse: [ aStream nextPutAll: '/' ]
]
