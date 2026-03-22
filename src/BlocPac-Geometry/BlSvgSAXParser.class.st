Class {
	#name : #BlSvgSAXParser,
	#superclass : #SAXHandler,
	#instVars : [
		'elements',
		'result',
		'instructions'
	],
	#category : #'BlocPac-Geometry-SVG'
}

{ #category : #views }
BlSvgSAXParser >> gtInputFor: aView [
	<gtView>
	input ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Input';
		object: [ XMLDOMParser parse: input ];
		view: #gtItemsFor:
]

{ #category : #views }
BlSvgSAXParser >> gtResultFor: aView [
	<gtView>
	result ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Result';
		stencil: [ self resultElement asScalableElement ]
]

{ #category : #'as yet unclassified' }
BlSvgSAXParser >> handleFillFrom: anAttributeDictionary inStatement: statement [
	^ anAttributeDictionary
		at: 'fill'
		ifPresent: [ :s | 
			statement
				, ';
	background: Color black' ]
		ifAbsent: [ statement ]
]

{ #category : #'as yet unclassified' }
BlSvgSAXParser >> handleStrokeFrom: anAttributeDictionary inStatement: statement [
	^ anAttributeDictionary
		at: 'stroke-width'
		ifPresent: [ :s | 
			statement
				, ';
	border: (BlBorder builder
		paint: Color black;
		width: ' , s
				, ';
		capRound;
		build)' ]
		ifAbsent: [ statement ]
]

{ #category : #'as yet unclassified' }
BlSvgSAXParser >> initialize [
	super initialize.
	result := BlElement new
			size: 16@16.
	instructions := OrderedCollection new.
]

{ #category : #views }
BlSvgSAXParser >> instructionString [
	^ instructions size = 1
		ifTrue: [ instructions first ]
		ifFalse: [ String
				streamContents: [ :s | 
					s
						nextPutAll: 'BlElement new size: 16@16; addChildren: {';
						nextPutAll: ('.' , String cr join: instructions);
						nextPutAll: '}' ] ]
]

{ #category : #views }
BlSvgSAXParser >> resultElement [
	^ OpalCompiler new
		source: self instructionString;
		evaluate
]

{ #category : #'as yet unclassified' }
BlSvgSAXParser >> startElement: aQualifiedName attributes: anAttributeDictionary [
	aQualifiedName = 'path'
		ifTrue: [ | statement |
			statement := 'BlElement new
	size: 16 @ 16;
	outskirts: BlOutskirts centered;
	geometry: (BlSvgPath new svg: ''' , (anAttributeDictionary at: 'd')
					, '''
	viewbox: (0 @ 0 extent: 16 @ 16))'.
			statement := self
					handleFillFrom: anAttributeDictionary
					inStatement: statement.
			statement := self
					handleStrokeFrom: anAttributeDictionary
					inStatement: statement.
			instructions add: statement ].
	aQualifiedName = 'rect'
		ifTrue: [ | statement |
			statement := 'BlElement new
	size: ' , (anAttributeDictionary at: 'width') , ' @ '
					, (anAttributeDictionary at: 'height')
					, ';
	relocate: ' , (anAttributeDictionary at: 'x') , ' @ '
					, (anAttributeDictionary at: 'y').
			statement := self
					handleFillFrom: anAttributeDictionary
					inStatement: statement.
			statement := self
					handleStrokeFrom: anAttributeDictionary
					inStatement: statement.
			instructions add: statement ].
	aQualifiedName = 'circle'
		ifTrue: [ | radius cx cy statement |
			radius := anAttributeDictionary at: 'r'.
			cx := anAttributeDictionary at: 'cx'.
			cy := anAttributeDictionary at: 'cy'.
			statement := 'BlElement new
	size: (' , radius , ' * 2) @ (' , radius
					, '* 2) ;
	relocate: (' , cx , ' - ' , radius , ') @ (' , cy , '-' , radius
					, ');
	geometry: BlCircleGeometry new'.
			statement := self
					handleFillFrom: anAttributeDictionary
					inStatement: statement.
			statement := self
					handleStrokeFrom: anAttributeDictionary
					inStatement: statement.
			instructions add: statement ]
]
