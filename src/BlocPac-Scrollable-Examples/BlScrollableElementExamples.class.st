"
# Scrollable element

Scrollable element allows users to display a larger element in a smaller frame (so called ""window"") with the ability to scroll the content both veritcally and horizontally.

Let's start by creating a content element which in our case will be a list of all subclasses of {{gtClass:SequenceableCollection}}. As you can see it is a quite tall element and it does not fit on a screen:
{{gtExample:BlScrollableElementExamples>>#scrollableContentInScalableElement|previewShow=#gtLiveFor:|previewHeight=250|previewExpanded|noCode}}

Therefore we want to wrap such large element in a new instance of {{gtClass:BlScrollableElement}}
{{gtExample:BlScrollableElementExamples>>#scrollableElement|previewShow=#gtLiveFor:|previewHeight=100}}

Once the `scrollable` element is instantiated we can add our previously created content as a direct child to the scrollable element with {{gtMethod:BlElement>>#addChild:}}
{{gtExample:BlScrollableElementExamples>>#scrollableElementWithContent|previewShow=#gtLiveFor:|previewHeight=75|previewExpanded}}

We quickly notice that the `scrollable` element does not have nice dimensions. We can fix it by asking the `scrollable` element to match it's parent.
{{gtExample:BlScrollableElementExamples>>#scrollableMatchParent|previewShow=#gtLiveFor:|previewHeight=300|previewExpanded}}

While being the most common use case, match parent is not the only resizing strategy supported by a `scrollable element`. Together with `maxHeight:` constraint a scrollable element can be used with `fit content`, which means that a scrollable element will grow in size to accommodate the scrolled element until reaching the limit set using `maxHeight:` or `maxWidth:`
{{gtExample:BlScrollableElementExamples>>#scrollableFitContentWithMaxHeight|previewShow=#gtLiveFor:|previewHeight=400|previewExpanded}}

"
Class {
	#name : #BlScrollableElementExamples,
	#superclass : #Object,
	#category : #'BlocPac-Scrollable-Examples'
}

{ #category : #'examples - setup' }
BlScrollableElementExamples >> data [
	^ #(#Alien #Array #ArrayedCollection #Bitmap #BlLayoutNodeChildren #TelemetryRecordings #BlWeakRef #ByteArray #ByteString #ByteSymbol #CairoGlyphsArray #ColorArray #CompiledBlock #CompiledCode #CompiledMethod #Cubic #DoubleByteArray #DoubleWordArray #ExternalAddress #FFIArray #FFICallbackReturnValue #FFICallbackThunk #FFIExternalArray #FFITypeArray #FloatArray #FreeTypeCacheLinkedList #GLMMultiValue #IntegerArray #Interval #LGitExternalArray #LGitExternalCommitArray #LGitExternalStringArray #LGitExternalUInt8Array #LinkedList #MetacelloMethodSectionPath #MyCompiledMethodForTesting #OCLiteralList #ObjectFinalizerCollection #OrderedCollection #PointArray #ProcessList #RunArray #Semaphore #ShortIntegerArray #SocketAddress #SortedCollection #SparseLargeArray #SparseLargeTable #Stack #String #Symbol #Text #UUID #VMCallbackContext32 #VMCallbackContext64 #WeakActionSequence #WeakArray #WeakOrderedCollection #WideString #WideSymbol #WordArray #XMLStubOrderedListCustomCollection)
]

{ #category : #'examples - setup' }
BlScrollableElementExamples >> scrollableContent [
	<gtExample>
	<return: #BlElement>
	| anElement |
	anElement := BlElement new.
	anElement layout: BlLinearLayout vertical.
	anElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	anElement
		addChildren: (self data
				flatCollect: [ :eachClassName | 
					{BlTextElement new
							text: eachClassName asRopedText;
							padding: (BlInsets left: 15);
							height: 45;
							constraintsDo: [ :c | c horizontal matchParent ].
						BlElement new
							background: (Color gray alpha: 0.2);
							constraintsDo: [ :c | 
								c horizontal matchParent.
								c vertical exact: 1 ]} ]).
	^ anElement
]

{ #category : #'examples - setup' }
BlScrollableElementExamples >> scrollableContentInScalableElement [
	<gtExample>
	<return: #BlScalableElement>
	^ self scrollableContent asScalableElement
]

{ #category : #'examples - setup' }
BlScrollableElementExamples >> scrollableElement [
	<gtExample>
	<return: #BlScrollableElement>
	^ BlScrollableElement new background: Color white
]

{ #category : #'examples - setup' }
BlScrollableElementExamples >> scrollableElementWithContent [
	<gtExample>
	<return: #BlScrollableElement>
	^ self scrollableElement addChild: self scrollableContent
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableExactHeight_01_default [
	<gtExample>
	<return: #BlScrollableElement>
	| aScrollableElement |
	aScrollableElement := self scrollableElementWithContent.
	aScrollableElement
		constraintsDo: [ :c | 
			c horizontal exact: 300.
			c vertical exact: 200 ].

	aScrollableElement forceLayout.
	self assert: aScrollableElement extent equals: 300 @ 200.
	self assert: aScrollableElement scrollPosition equals: 0 @ 0.
	self assert: aScrollableElement scrolledElement position equals: 0 @ 0.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableExactHeight_02_scrollToEnd [
	<gtExample>
	<return: #BlScrollableElement>
	| aScrollableElement |
	aScrollableElement := self scrollableExactHeight_01_default.
	aScrollableElement scrollBy: 0 @ 2852.

	aScrollableElement forceLayout.
	self assert: aScrollableElement scrolledElement height equals: 2852.0.
	self assert: aScrollableElement extent equals: 300 @ 200.
	self assert: aScrollableElement scrollPosition equals: 0 @ 2652 negated.
	self
		assert: aScrollableElement scrolledElement position
		equals: 0 @ 2652 negated.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableExactHeight_03_makeScrolledFixed [
	<gtExample>
	<return: #BlScrollableElement>
	| aScrollableElement |
	aScrollableElement := self scrollableExactHeight_02_scrollToEnd.
	aScrollableElement scrolledElement height: 200.

	aScrollableElement forceLayout.
	self assert: aScrollableElement scrolledElement height equals: 200.0.
	self assert: aScrollableElement extent equals: 300 @ 200.
	self assert: aScrollableElement scrollPosition equals: 0 @ 0.
	self assert: aScrollableElement scrolledElement position equals: 0 @ 0.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableFitContent [
	<gtExample>
	<return: #BlScrollableElement>
	| aScrollableElement |
	aScrollableElement := self scrollableElementWithContent.
	aScrollableElement
		constraintsDo: [ :c | 
			c horizontal exact: 300.
			c vertical fitContent ].

	aScrollableElement forceLayout.
	self assert: aScrollableElement scrolledElement height equals: 2852.0.
	self
		assert: aScrollableElement extent
		equals: 300 @ aScrollableElement scrolledElement height.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableFitContentWithMaxHeight [
	<gtExample>
	<return: #BlScrollableElement>
	| aScrollableElement |
	aScrollableElement := self scrollableElementWithContent.
	aScrollableElement
		constraintsDo: [ :c | 
			c horizontal exact: 300.
			c vertical fitContent.
			c maxHeight: 200 ].

	aScrollableElement forceLayout.
	self assert: aScrollableElement extent equals: 300 @ 200.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableMatchParemtWithMaxHeight [
	<gtExample>
	<return: #BlScrollableElement>
	| aScrollableElement |
	aScrollableElement := self scrollableElementWithContent.
	aScrollableElement
		constraintsDo: [ :c | 
			c horizontal exact: 300.
			c vertical matchParent.
			c maxHeight: 200 ].

	aScrollableElement forceLayout.
	self assert: aScrollableElement extent equals: 300 @ 200.

	^ aScrollableElement
]

{ #category : #examples }
BlScrollableElementExamples >> scrollableMatchParent [
	<gtExample>
	<return: #BlScrollableElement>
	| aScrollableElement |
	aScrollableElement := self scrollableElementWithContent.
	aScrollableElement
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	^ aScrollableElement
]
