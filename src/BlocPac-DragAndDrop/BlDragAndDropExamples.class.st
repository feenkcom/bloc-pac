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

{ #category : #'instance creation' }
BlDragAndDropExamples >> tagFor: aString [
	^ BlElement new
		layout: (BlLinearLayout horizontal alignCenter);
		constraintsDo: [ :c | c horizontal fitContent. c vertical fitContent ];
		margin: (BlInsets all: 5);
		padding: (BlInsets all: 10);
		background: Color veryVeryLightGray;
		border: (BlBorder paint: Color veryLightGray width: 1);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
		effect: (BlGaussianShadowEffect color: (Color lightGray alpha: 0.4) width: 2 offset: 0@0);
		addChild: (BlTextElement new
			labelMeasurement;
			text: aString asString asRopedText)
]

{ #category : #'instance creation' }
BlDragAndDropExamples >> tagOrdererDraggableTagFor: aString [
	^ (self tagFor: aString)
		withStylesDo: [ :theStyles |
			theStyles
				addStyle: (BlElementStyle new
					state: BlElementDraggingState uniqueInstance;
					background: Color veryLightGray);
			 	addStyle: (BlElementStyle new
					state: BlElementDraggingState uniqueInstance not;
					background: Color veryVeryLightGray)  ];
		addEventHandler: (BlDragHandler new liftItem: [ :aSourceElement |
			BlDragItem new
				sourceElement: aSourceElement;
				domainObject: aString;
				stencil: [ :aDragItem | self tagFor: aDragItem domainObject ] ]);
		when: BlAboutToBeDroppedEvent do: [ :anEvent | anEvent currentTarget removeFromParent ]
]

{ #category : #'instance creation' }
BlDragAndDropExamples >> tagOrdererSlidingTagFor: aString [
	^ (self tagFor: aString)
		withStylesDo: [ :theStyles |
			theStyles
				addStyle: (BlElementStyle new
					state: BlElementDraggingState uniqueInstance;
					visibility: BlVisibility hidden);
			 	addStyle: (BlElementStyle new
					state: BlElementDraggingState uniqueInstance not;
					visibility: BlVisibility visible)  ];
		addEventHandler: (BlDragHandler new
			dragArea: [ :aSourceElement | aSourceElement parent ];
			liftItem: [ :aSourceElement |
				BlDragItem new
					sourceElement: aSourceElement;
					domainObject: aString;
					stencil: [ :aDragItem | self tagFor: aDragItem domainObject ] ]);
		when: BlAboutToBeDroppedEvent do: [ :anEvent | anEvent currentTarget removeFromParent ]
]

{ #category : #accessing }
BlDragAndDropExamples >> tagsOrderer [
	<gtExample>
	| aContainer |

	aContainer := BlElement new.
	aContainer layout: (BlLinearLayout horizontal cellSpacing: 5).
	aContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	aContainer addEventHandler: (BlDropHandler new
		acceptOnlyFromThisElement;
		whenDragOverDo: [ :anItemsDraggedOverEvent |
			| container locationElement position childPosition |

			container := anItemsDraggedOverEvent currentTarget.
			locationElement := container
				childWithId: #'drop-area--drop-location'
				ifFound: [ :anElement | anElement ]
				ifNone: [
					| anElement |

					anElement := BlElement new
						background: Color orange;
						width: 2;
						constraintsDo: [ :c |
							c ignoreByLayout.
							c vertical matchParent ].

					container addChild: anElement as: #'drop-area--drop-location'.
					anElement ].

			position := anItemsDraggedOverEvent position x.
			childPosition := container children accountedByLayout
				detect: [ :eachChild | position < eachChild bounds inParent center x ] 
				ifFound: [ :eachChild | eachChild bounds inParent left - 10 ]
				ifNone: [ container children accountedByLayout last bounds inParent right + 10 ].

			locationElement relocate: childPosition @ 0 ];

		whenDragLeftDo: [ :anItemsLeftEvent | anItemsLeftEvent currentTarget removeChildNamed: #'drop-area--drop-location' ];
		whenHorizontalDroppedDo: [ :anItemsDroppedEvent :anIndex |
			(anItemsDroppedEvent items reverseDo: [ :eachDragItem |
				anItemsDroppedEvent currentTarget addChild: eachDragItem sourceElement at: anIndex ]) ]).

	aContainer addChildren: ({
		'One'.
		'Two'.
		'Three'.
		'Four'.
	} collect: [ :eachName | self tagOrdererDraggableTagFor: eachName ]).

	^ aContainer
]

{ #category : #accessing }
BlDragAndDropExamples >> tagsSlidingOrderer [
	<gtExample>
	| aContainer |

	aContainer := BlElement new.
	aContainer layout: (BlLinearLayout horizontal cellSpacing: 5).
	aContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].

	aContainer addEventHandler: (BlDropHandler new
		acceptOnlyFromThisElement;
		whenHorizontalSlideOverDo: [];
		whenDroppedDo: [ :anItemsDroppedEvent |
			| container position childBefore |

			container := anItemsDroppedEvent currentTarget.
			position := anItemsDroppedEvent position x.
			childBefore := container children accountedByLayout
				detect: [ :eachChild | position < (eachChild bounds inParent center x - 5) ]
				ifFound: [ :eachChild | eachChild ]
				ifNone: [ nil ].

			(anItemsDroppedEvent items collect: [ :eachDragItem | eachDragItem sourceElement ])
				do: [ :each |
					childBefore
						ifNil: [ container addChild: each ]
						ifNotNil: [ container addChild: each before: childBefore ] ] ]).

	aContainer addChildren: ({
		'One'.
		'Two'.
		'Three'.
		'Four'.
	} collect: [ :eachName | self tagOrdererSlidingTagFor: eachName ]).

	^ aContainer
]
