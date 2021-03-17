Class {
	#name : #BlElementQueryByElementPropertyPredicate,
	#superclass : #BlElementQueryByPredicate,
	#instVars : [
		'propertyName',
		'propertyValue'
	],
	#category : #'BlocPac-ElementQuery-Steps'
}

{ #category : #'api - query' }
BlElementQueryByElementPropertyPredicate >> findElementsIn: aCurrentQueryResult andAddTo: aNewQueryResult [
	aCurrentQueryResult
		forEach: [ :eachElement |
			aNewQueryResult wantsMore
				ifFalse: [ ^ self ].
			
			([
					| anElementPropertyValue myPropertyValue |
					
					anElementPropertyValue := eachElement perform: self propertyName asSymbol.
					
					"custom BlText comparison with String or other Texts is too useful to not have it"
					(anElementPropertyValue isKindOf: BlText)
						ifTrue: [ anElementPropertyValue := anElementPropertyValue characters ].
					
					myPropertyValue := self propertyValue.
					(myPropertyValue isKindOf: BlText)
						ifTrue: [ myPropertyValue := myPropertyValue characters ].
					
					anElementPropertyValue = myPropertyValue ]
				on: Error
				do: [ :anError | false ])
					ifTrue: [ aNewQueryResult addElement: eachElement ] ]
]

{ #category : #printing }
BlElementQueryByElementPropertyPredicate >> printOn: aStream [
	super printOn: aStream.
	
	aStream
		space;
		nextPut: $(;
		print: self propertyName;
		nextPutAll: ' -> ';
		print: self propertyValue;
		nextPut: $)
]

{ #category : #accessing }
BlElementQueryByElementPropertyPredicate >> propertyName [
	^ propertyName
]

{ #category : #accessing }
BlElementQueryByElementPropertyPredicate >> propertyName: anObject [
	propertyName := anObject
]

{ #category : #accessing }
BlElementQueryByElementPropertyPredicate >> propertyValue [
	^ propertyValue
]

{ #category : #accessing }
BlElementQueryByElementPropertyPredicate >> propertyValue: anObject [
	propertyValue := anObject
]
