Class {
	#name : #BlMobileSoftwareStatusBar,
	#superclass : #BlMobileSubElement,
	#category : #'BlocPac-Demos-Mobile phone'
}

{ #category : #'as yet unclassified' }
BlMobileSoftwareStatusBar >> createDateEl [
	^ (BlTextElement new)
		text: '11:27 AM' asRopedText;
		margin: (BlInsets all: 4);
		constraintsDo:
				[ :c | 
					c horizontal fitContent.
					c vertical fitContent.
					c linear horizontal alignCenter ];
		yourself
]

{ #category : #initialization }
BlMobileSoftwareStatusBar >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self background: Color white darker.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical exact: 18 ].
	self addChild: self createDateEl 
]
