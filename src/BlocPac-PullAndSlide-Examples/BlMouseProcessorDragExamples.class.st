Class {
	#name : #BlMouseProcessorDragExamples,
	#superclass : #BlMouseProcessorExamples,
	#category : #'BlocPac-PullAndSlide-Examples'
}

{ #category : #'examples - scripter' }
BlMouseProcessorDragExamples >> mouseDown [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mouseEnter.

	aScripter
		substeps: 'Mouse down'
		do: [ :aStep | 
			aStep
				mouseDown;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse down fired';
						value: [ :anElement | anElement draggable mouseDownCount ] equals: 1;
						onSelf ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorDragExamples >> mouseEnter [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scripter.
	aScripter element: self scripterElement.

	aScripter
		substeps: 'Mouse Enter'
		do: [ :aStep | 
			aStep mouseMove
				by: 30 @ 30;
				play.

			aStep mouseMove
				by: 50 @ 60;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse move fired';
						value: [ :anElement | anElement draggable mouseMoveCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse enter fired';
						value: [ :anElement | anElement draggable mouseEnterCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse over fired';
						value: [ :anElement | anElement draggable mouseOverCount ] equals: 1;
						onSelf ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorDragExamples >> mouseMove [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mouseDown.

	aScripter
		substeps: 'Mouse move'
		do: [ :aStep | 
			aStep mouseMove
				by: 160 @ 60;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check drag start enter fired';
						value: [ :anElement | anElement draggable dragStartCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check drag fired';
						value: [ :anElement | anElement draggable dragCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse move not fired because drag started';
						value: [ :anElement | anElement draggable mouseMoveCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check drag enter fired to the drop target';
						value: [ :anElement | anElement drop dragEnterCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check drag enter fired to the draggable target';
						value: [ :anElement | anElement draggable dragEnterCount ] equals: 1;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check element was dragged';
						value: [ :anElement | anElement draggable position ]
							equals: 210.0 @ 110.0;
						onSelf ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorDragExamples >> mouseUp [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self mouseMove.

	aScripter
		substeps: 'Mouse up'
		do: [ :aStep | 
			aStep
				mouseUp;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check element was dragged';
						value: [ :anElement | anElement draggable position ]
							equals: 210.0 @ 110.0;
						onSelf ].

			aStep
				checkStep: [ :s | 
					s
						label: 'Check mouse up fired';
						value: [ :anElement | anElement draggable mouseUpCount ] equals: 0;
						onSelf ].

			aStep
				checkStep: [  "aStep check
			label: 'Check drop is not fired on draggable';
			value: [ :anElement | anElement draggable dropCount ] equals: 0;
			onSelf;
			play.
		
		aStep check
			label: 'Check drop fired on the drop target';
			value: [ :anElement | anElement drop dropCount ] equals: 1;
			onSelf;
			play":s | 
					s
						label: 'Check drag end fired';
						value: [ :anElement | anElement draggable dragEndCount ] equals: 1;
						onSelf ] ].

	^ aScripter
]

{ #category : #'examples - scripter' }
BlMouseProcessorDragExamples >> scripterElement [
	<gtExample>
	<return: #BlExampleDragAndDropElement>
	^ BlExampleDragAndDropElement new
]
