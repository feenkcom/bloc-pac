Class {
	#name : #BlPullHandlerExamples,
	#superclass : #Object,
	#category : #'BlocPac-PullAndSlide-Examples'
}

{ #category : #'examples - pull' }
BlPullHandlerExamples >> allowOutOfBounds [
	<gtExample>
	<return: #BlElement>
	| aPullable aContainer |
	aPullable := BlElement new
			border: (BlBorder paint: Color lightGray width: 2);
			background: Color veryLightGray;
			size: 100 @ 100;
			addEventHandler: BlPullHandler new allowOutOfBounds.

	aContainer := BlElement new
			background: Color veryVeryLightGray;
			size: 400 @ 300;
			addChild: aPullable.

	^ aContainer
]

{ #category : #'examples - pull' }
BlPullHandlerExamples >> disallowOutOfBounds [
	<gtExample>
	<return: #BlElement>
	| aPullable aContainer |
	aPullable := BlElement new
			border: (BlBorder paint: Color lightGray width: 2);
			background: Color veryLightGray;
			size: 100 @ 100;
			addEventHandler: BlPullHandler new disallowOutOfBounds.

	aContainer := BlElement new
			background: Color veryVeryLightGray;
			size: 400 @ 300;
			addChild: aPullable.

	^ aContainer
]
