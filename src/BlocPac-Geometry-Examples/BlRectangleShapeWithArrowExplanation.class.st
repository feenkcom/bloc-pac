"
# Rectangle geometry with arrow pointer

The goal of this tutorial is to create an element with an arrow-like pointer in the middle of the top edge, as shown below:
{{gtExample:BlRectangleShapeWithArrowExplanation>>#elementWithTopArrowGeometry|noCode|previewShow=gtLiveFor:|previewHeight=250}}

A traditional way to implement such geometry is to create a subclass of {{gtClass:BlElementVectorGeometry}},  override {{gtMethod:BlElementVectorGeometry>>#buildPathOnSpartaCanvas:}} and implement quite a cumbersome algorithm that computes the location of each point and then connects those points using the `moveTo:` and `lineTo:` commands provided by `PathBuilder`. The problem with such a solution is its exponential increase in complexity each time we would like to parametrize and customize the resulting geometry, for example the size of the arrow or its horizontal position. Even more complex would be to implement support for positioning the arrow on different edges (e.g. left, bottom) or the ability to have multiple arrows on separate edges.

This is where a {{gtClass:TBlShaperFigure}} comes-in handy.

## Creating a rectangle shape

We will start with the creation of the rectangle shape, a {{gtClass:BlShaperPolygon}}:
{{gtExample:BlRectangleShapeWithArrowExplanation>>#rectangleShape|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=250}}

## Translating the top edge

In order to give the protruding arrow enough space we should move the top edge of the rectangle down by the length of the arrow. First of all, we should ask the rectangle shape to give us its top edge via {{gtMethod:BlShaperPolygon>>#edgeAt:}}. By default, the `topEdge` of the rectangle is an instance of {{gtClass:BlShaperLine}} which can be translated by sending {{gtMethod:BlShaperLine>>#moveBy:}} to the `topEdge`, as shown below.
{{gtExample:BlRectangleShapeWithArrowExplanation>>#rectangleWithTranslatedTopEdge|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=250}}

## Injecting a line inside of the top edge

The next step on our way to the arrow is to inject a line segment equal to the length of the arrow in the middle of the `topEdge`. It can be done by sending {{gtMethod:BlShaperLine>>#injectLineAt:length:}} to the `topEdge`. Since we want to inject a line right in the middle of the edge, we pass `0.5` as the line location:
{{gtExample:BlRectangleShapeWithArrowExplanation>>#rectangleWithTopInjectedLine|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=250}}

## Splitting the injected line

We are almost ready to create our arrow. We just need to split the injected line in half in order to create the point of the arrow. We can do so by sending {{gtMethod:BlShaperLine>>#splitAt:}} to the (now) middle section of the `topEdge`, which was created by the previous line injection step:
{{gtExample:BlRectangleShapeWithArrowExplanation>>#rectangleWithTopPolylineSplitInHalf|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=250}}

## Moving the top of the triangle

Once we have everything we need for the arrow triangle we can move its top up by the length of the arrow. To do so, we should send {{gtMethod:BlShaperVertex>>#moveBy:}} to the connection point of the split line in the middle of the `topEdge`. After doing so, we get the expected vector shape that we can later use with {{gtClass:BlShaperGeometry}}:
{{gtExample:BlRectangleShapeWithArrowExplanation>>#rectangleWithTopArrow|previewExpanded=true|previewHeight=350}}


"
Class {
	#name : #BlRectangleShapeWithArrowExplanation,
	#superclass : #Object,
	#category : #'BlocPac-Geometry-Examples'
}

{ #category : #accessing }
BlRectangleShapeWithArrowExplanation >> arrowLength [
	^ 30
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> elementTallWithTopArrowGeometry [
	<gtExample>
	
	^ BlElement new
		geometry: (BlShaperGeometry new shape: (self rectangleWithTopArrow));
		size: 300@400;
		background: (Color veryVeryLightGray);
		border: (BlBorder paint: Color black width: 2)
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> elementWithTopArrowGeometry [
	<gtExample>
	
	^ BlElement new
		geometry: (BlShaperGeometry new shape: (self rectangleWithTopArrow));
		size: 300@200;
		background: (Color veryVeryLightGray);
		border: (BlBorder paint: Color lightGray width: 10)
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> rectangleShape [
	<gtExample>
	| aRectangle |
	
	aRectangle := BlShaperPolygon rectangle: (50@50 extent: 250@150).

	self assert: aRectangle edges size equals: 4.

	^ aRectangle
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> rectangleWithTopArrow [
	<gtExample>
	| aRectangle |
	
	aRectangle := self rectangleWithTopPolylineSplitInHalf.
	(aRectangle edgeAt: 2) toVertex moveBy: 0 @ self arrowLength negated.

	^ aRectangle
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> rectangleWithTopInjectedLine [
	<gtExample>
	| aRectangle |
	
	aRectangle := self rectangleWithTranslatedTopEdge.
	(aRectangle edgeAt: 1)
		injectLineAt: 0.5 length: self arrowLength.

	^ aRectangle
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> rectangleWithTopPolylineSplitInHalf [
	<gtExample>
	| aRectangle |
	
	aRectangle := self rectangleWithTopInjectedLine.
	(aRectangle edgeAt: 2) splitAt: 0.5.

	^ aRectangle
]

{ #category : #'examples - rectangle' }
BlRectangleShapeWithArrowExplanation >> rectangleWithTranslatedTopEdge [
	<gtExample>
	| aRectangle |
	
	aRectangle := self rectangleShape.
	(aRectangle edgeAt: 1) moveBy: (0@ self arrowLength).

	^ aRectangle
]
