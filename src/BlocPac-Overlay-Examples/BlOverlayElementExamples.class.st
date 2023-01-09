Class {
	#name : #BlOverlayElementExamples,
	#superclass : #Object,
	#category : #'BlocPac-Overlay-Examples'
}

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnParent [
	"An overlay is attached to the parent and is added as a child to said parent.
	As a result, an overlay always assumes the size of the parent. Honestly,
	this feature is quite pointless to use because the same can be achieved by simply matching parent and using #ignoreByLayout."
	<gtExample>
	| aContainer anOverlay |
	
	aContainer := BlElement new
		size: 500@400;
		border: (BlBorder builder dashed; paint: Color gray; width: 2; build).
	
	anOverlay := BlOverlayElement on: aContainer.
	anOverlay background: (Color gray alpha: 0.2).
	
	aContainer addChild: anOverlay as: #overlay.
	
	^ aContainer
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnParentByScripter [
	<gtExample>
	| aScripter |
	
	aScripter := BlScripter new.
	aScripter element: self overlayOnParent.
	
	aScripter assert
		id: #overlay;
		value: [ :anOveray | anOveray extent ] equals: 500@400;
		value: [ :anOveray | anOveray position ] equals: 0@0;
		play.

	aScripter do
		label: 'Relocate and resize the container';
		action: [ :aContainer |
			aContainer
				relocate: 100@50;
				size: 300@200 ];
		play.
	
	aScripter assert
		id: #overlay;
		value: [ :anOveray | anOveray extent ] equals: 500@400;
		value: [ :anOveray | anOveray position ] equals: 0@0;
		play.
	
	^ aScripter
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnScaledSibling [
	"An overlay which is attached to its scaled down sibling with a common parent. This is a quite common usecase if you want one element to always be the size of another element and overlap."
	<gtExample>
	| aContainer aSibling anOverlay |
	
	aContainer := BlElement new
		size: 500@400;
		border: (BlBorder builder dashed; paint: Color gray; width: 2; build).
	
	aSibling := BlElement new
		size: 300@200;
		border: (BlBorder paint: Color gray width: 2);
		transformDo: [ :t | t scaleBy: 0.5 ];
		addEventHandler: BlPullHandler new.
	
	anOverlay := BlOverlayElement on: aSibling.
	anOverlay preventMeAndChildrenMouseEvents.
	anOverlay background: (Color gray alpha: 0.2).
	
	aContainer addChild: aSibling as: #sibling.
	aContainer addChild: anOverlay as: #overlay.
	
	^ aContainer
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnScaledSiblingByScripter [
	<gtExample>
	| aScripter |
	
	aScripter := BlScripter new.
	aScripter element: self overlayOnScaledSibling.
	
	aScripter assert
		id: #overlay;
		value: [ :anOveray | anOveray extent ] equals: 150@100;
		value: [ :anOveray | anOveray position ] equals: 0@0;
		play.
		
	aScripter assert
		id: #sibling;
		value: [ :aSibling | aSibling extent ] equals: 300@200;
		value: [ :aSibling | aSibling position ] equals: 0@0;
		play.

	aScripter do
		label: 'Relocate and resize the sibling';
		id: #sibling;
		action: [ :aSibling |
			aSibling
				size: 200@100;
				relocate: 100@50 ];
		play.
	
	aScripter assert
		id: #sibling;
		value: [ :aSibling | aSibling extent ] equals: 200@100;
		value: [ :aSibling | aSibling position ] equals: 100@50;
		play.
	
	aScripter assert
		id: #overlay;
		value: [ :anOveray | anOveray extent ] equals: 100@50;
		"overlay's position doesn't match the one of the sibling because the
		transformation origin is #centerOrigin. It would match if the origin would have been #topLeftOrigin"
		value: [ :anOveray | anOveray position ] equals: 150@75;
		play.
	
	^ aScripter
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnSibling [
	"An overlay which is attached to its sibling with a common parent. This is a quite common usecase if you want one element to always be the size of another element and overlap."
	<gtExample>

	^ self overlayOnSiblingWithContainerClass: BlElement
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnSiblingByScripter [
	<gtExample>
	| aScripter |
	
	aScripter := BlScripter new.
	aScripter element: self overlayOnSibling.
	
	aScripter assert
		id: #overlay;
		value: [ :anOveray | anOveray extent ] equals: 300@200;
		value: [ :anOveray | anOveray position ] equals: 0@0;
		play.
		
	aScripter assert
		id: #sibling;
		value: [ :aSibling | aSibling extent ] equals: 300@200;
		value: [ :aSibling | aSibling position ] equals: 0@0;
		play.

	aScripter do
		label: 'Relocate and resize the sibling';
		id: #sibling;
		action: [ :aSibling |
			aSibling
				relocate: 100@50;
				size: 200@100 ];
		play.
	
	aScripter assert
		id: #overlay;
		value: [ :anOveray | anOveray extent ] equals: 200@100;
		value: [ :anOveray | anOveray position ] equals: 100@50;
		play.
	
	^ aScripter
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnSiblingInParentWithChildrenTransformation [
	"An overlay which is attached to its sibling with a common parent that implements support for children transformation. This is a quite common usecase if you want one element to always be the size of another element and overlap."
	<gtExample>
	
	^ (self overlayOnSiblingWithContainerClass: BlOverlayExampleElementWithChildrenTransformation)
		childrenTransformDo: [ :t | t topLeftOrigin scaleBy: 0.5 ]
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnSiblingInParentWithChildrenTransformationByScripter [
	<gtExample>
	| aScripter |
	
	aScripter := BlScripter new.
	aScripter element: self overlayOnSiblingInParentWithChildrenTransformation.
	
	aScripter assert
		id: #overlay;
		value: [ :anOveray | anOveray extent ] equals: 300@200;
		value: [ :anOveray | anOveray position ] equals: 0@0;
		play.
		
	aScripter assert
		id: #sibling;
		value: [ :aSibling | aSibling extent ] equals: 300@200;
		value: [ :aSibling | aSibling position ] equals: 0@0;
		play.

	aScripter do
		label: 'Relocate and resize the sibling';
		id: #sibling;
		action: [ :aSibling |
			aSibling
				relocate: 100@50;
				size: 200@100 ];
		play.
	
	aScripter assert
		id: #overlay;
		value: [ :anOveray | anOveray extent ] equals: 200@100;
		value: [ :anOveray | anOveray position ] equals: 100@50;
		play.
	
	^ aScripter
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnSiblingInScaledParent [
	"An overlay which is attached to its sibling with a common parent that is scaled down. This is a quite common usecase if you want one element to always be the size of another element and overlap."
	<gtExample>
	
	^ self overlayOnSibling
		transformDo: [ :t | t topLeftOrigin scaleBy: 0.5 ]
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnSiblingInScaledParentByScripter [
	<gtExample>
	| aScripter |
	
	aScripter := BlScripter new.
	aScripter element: self overlayOnSiblingInScaledParent.
	
	aScripter assert
		id: #overlay;
		value: [ :anOveray | anOveray extent ] equals: 300@200;
		value: [ :anOveray | anOveray position ] equals: 0@0;
		play.
		
	aScripter assert
		id: #sibling;
		value: [ :aSibling | aSibling extent ] equals: 300@200;
		value: [ :aSibling | aSibling position ] equals: 0@0;
		play.

	aScripter do
		label: 'Relocate and resize the sibling';
		id: #sibling;
		action: [ :aSibling |
			aSibling
				relocate: 100@50;
				size: 200@100 ];
		play.
	
	aScripter assert
		id: #overlay;
		value: [ :anOveray | anOveray extent ] equals: 200@100;
		value: [ :anOveray | anOveray position ] equals: 100@50;
		play.
	
	^ aScripter
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnSiblingWithContainerClass: anElementClass [
	"An overlay which is attached to its sibling with a common parent. This is a quite common usecase if you want one element to always be the size of another element and overlap."
	<gtExample>
	| aContainer aSibling anOverlay |
	
	aContainer := anElementClass new
		size: 500@400;
		border: (BlBorder builder dashed; paint: Color gray; width: 2; build).
	
	aSibling := BlElement new
		size: 300@200;
		border: (BlBorder paint: Color gray width: 2);
		addEventHandler: BlPullHandler new.
	
	anOverlay := BlOverlayElement on: aSibling.
	anOverlay preventMeAndChildrenMouseEvents.
	anOverlay background: (Color gray alpha: 0.2).
	
	aContainer addChild: aSibling as: #sibling.
	aContainer addChild: anOverlay as: #overlay.
	
	^ aContainer
]
