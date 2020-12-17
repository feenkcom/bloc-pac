Class {
	#name : #BaselineOfBlocPacDragAndDrop,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacDragAndDrop
}

{ #category : #baseline }
BaselineOfBlocPacDragAndDrop >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocAnimation' with: [
				spec repository: 'github://feenkcom/Bloc/src' ].
		spec 
			package: #'BlocPac-DragAndDrop' with: [
				spec requires: #(#'BlocCore' #'BlocAnimation') ] ].
]
