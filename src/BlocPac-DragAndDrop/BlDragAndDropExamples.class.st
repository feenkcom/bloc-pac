Class {
	#name : #BlDragAndDropExamples,
	#superclass : #Object,
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #'instance creation' }
BlDragAndDropExamples >> labelContainer: anElement with: aText [
	^ BlElement new
		layout: (BlLinearLayout vertical alignTopCenter cellSpacing: 10);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: (BlTextElement new text: aText asRopedText);
		addChild: anElement
]

{ #category : #'instance creation' }
BlDragAndDropExamples >> letterFor: aCharacter [
	^ BlElement new
		layout: (BlLinearLayout horizontal alignCenter);
		size: 30@30;
		margin: (BlInsets all: 5);
		background: Color veryVeryLightGray;
		border: (BlBorder paint: Color veryLightGray width: 1);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		effect: (BlGaussianShadowEffect color: (Color lightGray alpha: 0.4) width: 2 offset: 0@0);
		addChild: (BlTextElement new
			labelMeasurement;
			text: aCharacter asString asRopedText)
]

{ #category : #examples }
BlDragAndDropExamples >> lettersSorter [
	<gtExample>
	| letters vowels consonants |
	letters := self lettersSorterContainer.
	vowels := self lettersSorterRoundedContainerWithBorder.
	vowels
		addEventHandler: (BlDropHandler new
				acceptItemsSuchThat: [ :aDragItem :aDropArea | aDragItem sourceElement parent ~~ aDropArea ];
				acceptDomainObjectsSuchThat: [ :anObject | anObject isCharacter and: [ anObject isVowel ] ];
				whenDroppedDo: [ :anItemsDroppedEvent | 
					anItemsDroppedEvent currentTarget
						addChildren: (anItemsDroppedEvent items
								collect: [ :eachDragItem | self lettersSorterDraggableLetterFor: eachDragItem domainObject ]) ]).

	consonants := self lettersSorterRoundedContainerWithBorder.
	consonants
		addEventHandler: (BlDropHandler new
				acceptItemsSuchThat: [ :aDragItem :aDropArea | aDragItem sourceElement parent ~~ aDropArea ];
				acceptDomainObjectsSuchThat: [ :anObject | anObject isCharacter and: [ anObject isVowel not ] ];
				whenDroppedDo: [ :anItemsDroppedEvent | 
					anItemsDroppedEvent currentTarget
						addChildren: (anItemsDroppedEvent items
								collect: [ :eachDragItem | self lettersSorterDraggableLetterFor: eachDragItem domainObject ]) ]).

	letters
		addChildren: ({$a.
				$c.
				$Q.
				$o.
				$j.
				$E.
				$y.
				$Z.
				$U.
				$B.
				$p.
				$i} collect: [ :each | self lettersSorterDraggableLetterFor: each ]).

	^ BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 30);
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addChildren: {self labelContainer: letters with: 'Letters to sort'.
				self labelContainer: vowels with: 'Vowel letters'.
				self labelContainer: consonants with: 'Consonant letters'}
]

{ #category : #'instance creation' }
BlDragAndDropExamples >> lettersSorterContainer [
	^ BlElement new
		layout: BlFlowLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		padding: (BlInsets all: 10)
]

{ #category : #'instance creation' }
BlDragAndDropExamples >> lettersSorterDraggableLetterFor: aCharacter [
	^ (self letterFor: aCharacter)
		addEventHandler: (BlDragHandler new liftItem: [ :aSourceElement |
			BlDragItem new
				sourceElement: aSourceElement;
				domainObject: aCharacter;
				stencil: [ :aDragItem | self letterFor: aDragItem domainObject ] ]);
		when: BlAboutToBeDroppedEvent do: [ :anEvent | anEvent currentTarget removeFromParent ]
]

{ #category : #'instance creation' }
BlDragAndDropExamples >> lettersSorterRoundedContainerWithBorder [
	^ self lettersSorterContainer
		border: (BlBorderBuilder new
			paint: Color gray;
			dashed;
			width: 2;
			build);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 5)
]

{ #category : #accessing }
BlDragAndDropExamples >> tagsOrderer [
	<gtExample>
	| aContainer |
	
	aContainer := BlElement new.
	aContainer layout: (BlLinearLayout horizontal cellSpacing: 5).
	aContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	
	
	^ aContainer
]
