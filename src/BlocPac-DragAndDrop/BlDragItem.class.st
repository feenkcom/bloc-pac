"
I represent a model object and embody a drag preview and item provider

"
Class {
	#name : #BlDragItem,
	#superclass : #Object,
	#instVars : [
		'sourceElement',
		'domainObject',
		'draggedElement',
		'draggedElementStencil'
	],
	#category : #'BlocPac-DragAndDrop'
}

{ #category : #'instace creation' }
BlDragItem >> createDraggedElement [
	<return: #BlElement>

	^ draggedElementStencil
		dragItem: self;
		build
]

{ #category : #accessing }
BlDragItem >> domainObject [
	^ domainObject
]

{ #category : #accessing }
BlDragItem >> domainObject: anObject [
	domainObject := anObject
]

{ #category : #accessing }
BlDragItem >> draggedElement [
	^ draggedElement ifNil: [ draggedElement := self createDraggedElement ]
]

{ #category : #accessing }
BlDragItem >> initialize [
	super initialize.

	draggedElementStencil := BlDragItemStencil new
]

{ #category : #accessing }
BlDragItem >> previewElement [
	^ self draggedElement
]

{ #category : #accessing }
BlDragItem >> sourceElement [
	^ sourceElement
]

{ #category : #accessing }
BlDragItem >> sourceElement: anObject [
	sourceElement := anObject
]

{ #category : #accessing }
BlDragItem >> stencil [
	^ draggedElementStencil
]

{ #category : #accessing }
BlDragItem >> stencil: aBlDragItemStencil [
	draggedElementStencil := aBlDragItemStencil asStencilBuilder: BlDragItemStencil
]
