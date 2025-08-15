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
		dataBinder: [ :eachLabel :eachNumber | eachLabel text: eachLabel asString ];
		items: (1 to: 500).
	
	list := BlVirtualListElement new
		dataSource: dataSource.
	
	list background: Color veryVeryLightGray.
	
	list constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	
	^ list
]

{ #category : #'as yet unclassified' }
BlVirtualListFitContentExamples >> listOfNestedItems [
	<gtExample>
	| dataSource list |
	
	dataSource := BlVirtualListExplicitDataSource new
		elementStencil: [
			| nestedDataSource nestedList |
			nestedDataSource := BlVirtualListExplicitDataSource new
				elementStencil: [ BrLabel new aptitude: BrGlamorousLabelAptitude ];
				dataBinder: [ :eachLabel :eachNumber | eachLabel text: eachNumber asString ];
				items: (1 to: 100).
			nestedList := BlVirtualListElement new
				dataSource: nestedDataSource.
				
			nestedList constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal matchParent ].
			nestedList ];
		dataBinder: [ :eachLabel :eachNumber |  ];
		items: (1 to: 3).
	
	list := BlVirtualListElement new
		dataSource: dataSource.
	
	list background: Color veryVeryLightGray.
	
	list constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	
	^ list
]

{ #category : #'as yet unclassified' }
BlVirtualListFitContentExamples >> listOfNestedItemsWithFixedElements [
	<gtExample>
	| dataSource list |
	
	dataSource := BlVirtualListExplicitDataSource new
		elementStencil: [
			| nestedDataSource nestedList |
			nestedDataSource := BlVirtualListExplicitDataSource new
				elementStencil: [ BrLabel new aptitude: BrGlamorousLabelAptitude ];
				dataBinder: [ :eachLabel :eachNumber | eachLabel text: eachNumber asString ];
				items: (1 to: 100).
			nestedList := BlVirtualListElement new
				dataSource: nestedDataSource.

			nestedList constraintsDo: [ :c |
				c vertical fitContent.
				c horizontal matchParent ].
			nestedList.
			
			BlElement new
				layout: BlViewportAwareVerticalLayout new;
				constraintsDo: [ :c |
					c vertical fitContent.
					c horizontal matchParent ];
				addChildren: {
					BrVerticalPane new
						hMatchParent;
						vFitContent;
						addChild: nestedList.
					BlElement new
						size: 200@50;
						background: Color random.
				}
			
			 ];
		dataBinder: [ :eachLabel :eachNumber |  ];
		items: (1 to: 3).
	
	list := BlVirtualListElement new
		dataSource: dataSource.
	
	list background: Color veryVeryLightGray.
	
	list constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].
	
	^ list
]
