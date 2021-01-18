Class {
	#name : #BlInfiniteMouseScrollDirectionDummyElement,
	#superclass : #BlInfiniteElement,
	#instVars : [
		'scrolls'
	],
	#category : #'BlocPac-Infinite-Examples'
}

{ #category : #'as yet unclassified' }
BlInfiniteMouseScrollDirectionDummyElement >> gtScrollsFor: aView [
	<gtView>
	self scrolls ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Scrolls';
		tooltip: 'Performed scrolls';
		priority: -1;
		items: [ self scrolls ]
]

{ #category : #initialization }
BlInfiniteMouseScrollDirectionDummyElement >> initialize [
	super initialize.
	scrolls := OrderedCollection new.
]

{ #category : #'api - accessing' }
BlInfiniteMouseScrollDirectionDummyElement >> scrolls [
	^ scrolls
]

{ #category : #'api - accessing' }
BlInfiniteMouseScrollDirectionDummyElement >> scrolls: anObject [
	scrolls := anObject
]

{ #category : #scrolling }
BlInfiniteMouseScrollDirectionDummyElement >> smoothScrollBy: aPoint [
	self scrolls addLast: aPoint.
	super smoothScrollBy: aPoint.
]
