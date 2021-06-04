"
# Polygon element
The element's position and size is determined by a collection of attached anchors.
## Triangle
{{gtExample:BlPolygonElementExamples>>#triangle|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=200}}
## Square
{{gtExample:BlPolygonElementExamples>>#square|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=150}}
## Rectangle
{{gtExample:BlPolygonElementExamples>>#rectangle|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=150}}
## Octagon
{{gtExample:BlPolygonElementExamples>>#octagon|codeExpanded=false|previewExpanded=true|previewShow=#gtLiveFor:|previewHeight=200}}

"
Class {
	#name : #BlPolygonElement,
	#superclass : #BlGeometryElement,
	#instVars : [
		'anchors'
	],
	#category : #'BlocPac-Geometry-Figures'
}

{ #category : #'anchor - geometry' }
BlPolygonElement >> anchorPositions [	
	^ self anchors collect: [ :eachAnchor | eachAnchor positionWithin: self ]
]

{ #category : #accessing }
BlPolygonElement >> anchors [
	^ anchors
]

{ #category : #accessing }
BlPolygonElement >> anchors: aCollectionOfAnchors [
	anchors do: [ :eachAnchor | self unregisterAnchor: eachAnchor ].
	anchors := aCollectionOfAnchors.
	anchors do: [ :eachAnchor | self registerAnchor: eachAnchor ]
]

{ #category : #initialization }
BlPolygonElement >> initialize [
	super initialize.
	
	visuals := BlCustomVisuals new
		geometry: BlPolygon new.
	
	anchors := { 
		BlAbsolutePositionAnchor position: 50@0.
		BlAbsolutePositionAnchor position: 100@50.
		BlAbsolutePositionAnchor position: 50@100.
		BlAbsolutePositionAnchor position: 0@50.
	}
]

{ #category : #layout }
BlPolygonElement >> layoutBounds [
	<return: #Rectangle>
	
	^ Rectangle encompassing: self anchorPositions
]

{ #category : #layout }
BlPolygonElement >> measureGeometry [
	| theAnchorPositions	anOrigin |

	theAnchorPositions := self anchorPositions.
	anOrigin := theAnchorPositions
		ifEmpty: [ 0@0 ]
		ifNotEmpty: [ theAnchorPositions first ].
	theAnchorPositions allButFirstDo: [ :eachPosition | anOrigin := anOrigin min: eachPosition ].
	self geometry vertices: (theAnchorPositions collect: [ :eachPosition | eachPosition - anOrigin ])
]

{ #category : #accessing }
BlPolygonElement >> vertices: aCollectionOfPoints [
	self anchors: (aCollectionOfPoints collect: [ :eachPoint | BlAbsolutePositionAnchor position: eachPoint ])
]
