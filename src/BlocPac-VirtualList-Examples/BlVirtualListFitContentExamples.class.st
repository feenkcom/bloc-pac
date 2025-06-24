Class {
	#name : #BlVirtualListFitContentExamples,
	#superclass : #Object,
	#category : #'BlocPac-VirtualList-Examples'
}

{ #category : #'as yet unclassified' }
BlVirtualListFitContentExamples >> listOfFiveItems [
	<gtExample>
	| dataSource list |
	
	dataSource := BlVirtualListExplicitDataSource new
		elementStencil: [ BrLabel new aptitude: BrGlamorousLabelAptitude ];
		dataBinder: [ :eachLabel :eachNumber | eachLabel text: eachNumber asString ];
		items: (1 to: 5).
	
	list := BlVirtualListElement new
		dataSource: dataSource.
	
	list background: Color veryVeryLightGray.
	
	list constraintsDo: [ :c |
		c vertical fitContent.
		c horizontal matchParent ].
	
	^ list
]

{ #category : #'as yet unclassified' }
BlVirtualListFitContentExamples >> listOfNestedItems [
	<gtExample>
	| dataSource list |
	
	dataSource := BlVirtualListExplicitDataSource new
		elementStencil: [
			| nestedDataSource nestedList|
			nestedDataSource := BlVirtualListExplicitDataSource new
				elementStencil: [ BrLabel new aptitude: BrGlamorousLabelAptitude ];
				dataBinder: [ :eachLabel :eachNumber | eachLabel text: eachLabel asString ];
				items: (1 to: 5).
			nestedList := BlVirtualListElement new
				dataSource: nestedDataSource.
				
			nestedList constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal matchParent ].
			nestedList ];
		dataBinder: [ :eachLabel :eachNumber |  ];
		items: (1 to: 5).
	
	list := BlVirtualListElement new
		dataSource: dataSource.
	
	list background: Color veryVeryLightGray.
	
	list constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	
	^ list
]
