Trait {
	#name : #TBlElementError,
	#instVars : [
		'errorText',
		'exception',
		'errorStencil'
	],
	#category : #'BlocPac-ErrorHandling'
}

{ #category : #private }
TBlElementError >> defaultErrorStencil [

	^ BrValuableStencil new valuable: [ :anException | | container message |
		container := BlElement new.
		container layout: BlLinearLayout horizontal.
		message := errorText ifNil: [ anException messageText ].
		container addChild: (BlTextElement new
			text: 'Debug' translated asRopedText;
			border: (BlBorder paint: Color gray width: 1);
			labelMeasurement;
			background: Color white;
			padding: (BlInsets top: 5 left: 8 bottom: 5 right: 8);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			when: BlClickEvent do: [ [ anException defaultAction ] fork ]).
		container addChild: (BlTextElement new 
			margin: (BlInsets left: 10 right: 10);
			constraintsDo: [ :c |
				c horizontal exact: 1200.
				c vertical exact: 14 ];
			text: message asRopedText).
		container ].
]

{ #category : #accessing }
TBlElementError >> errorStencil [

	^ errorStencil ifNil: [ self defaultErrorStencil ]
]

{ #category : #accessing }
TBlElementError >> errorStencil: anObject [
	errorStencil := anObject
]

{ #category : #accessing }
TBlElementError >> errorText [
	^ errorText
]

{ #category : #accessing }
TBlElementError >> errorText: anObject [
	errorText := anObject
]

{ #category : #accessing }
TBlElementError >> exception [
	^ exception
]

{ #category : #accessing }
TBlElementError >> exception: anException [
	"Set the exception raised while trying to generate the receiver's content.
	This can be called from a background process, so ensure element updates occur in the UI process"

	anException freeze.
	exception := anException.
	BlUseAsyncFeatures 
		ifEnabledDo: [ self inUIProcessDo: self exceptionAction ]
		otherwise: [ self exceptionAction value ]
]

{ #category : #accessing }
TBlElementError >> exceptionAction [

	^ [ self removeChildren.
		exception ifNotNil: [ | exceptionElement |
				exceptionElement := (self errorStencil arguments: { exception }) create.
				exceptionElement constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent.
					c frame vertical alignCenter.
					c frame horizontal alignCenter ].
				self addChild: exceptionElement ] ]
]
