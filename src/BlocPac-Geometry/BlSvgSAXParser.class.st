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
BlSvgSAXParser >> initialize [
	super initialize.
	result := BlElement new
			size: 16@16.
	instructions := OrderedCollection new.
]

{ #category : #views }
BlSvgSAXParser >> instructionString [
	^ String streamContents: [:s | 
		s 
			nextPutAll: 'BlElement new size: 16@16; addChildren: {';
			nextPutAll: ('.', String cr join: instructions);
			nextPutAll: '}' ]
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
			anAttributeDictionary
				at: 'fill'
				ifPresent: [ :s | 
					statement := statement
							, ';
	background: Color black' ].
			anAttributeDictionary
				at: 'stroke-width'
				ifPresent: [ :s | 
					statement := statement
							, ';
	border: (BlBorder builder
		paint: Color black;
		width: ' , s
							, ';
		capRound;
		build)' ].
			instructions add: statement ].
	aQualifiedName = 'rect'
		ifTrue: [ instructions
				add: 'BlElement new
	size: ' , (anAttributeDictionary at: 'width') , ' @ '
						, (anAttributeDictionary at: 'height')
						, ';
	relocate: ' , (anAttributeDictionary at: 'x') , ' @ '
						, (anAttributeDictionary at: 'y')
						, ';
	outskirts: BlOutskirts centered;
	background: Color black;
	border: (BlBorder builder
		paint: Color black;
		width: 1;
		capRound;
		build)' ].
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
			anAttributeDictionary
				at: 'fill'
				ifPresent: [ :s | 
					statement := statement
							, ';
	background: Color black' ].
			anAttributeDictionary
				at: 'stroke-width'
				ifPresent: [ :s | 
					statement := statement
							, ';
	border: (BlBorder builder
		paint: Color black;
		width: ' , s
							, ';
		capRound;
		build)' ].
			instructions add: statement ]
]
