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
				self repository: 'github://feenkcom/Bloc/src' for: spec ];
			baseline: 'BlocAnimation' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ].
		spec 
			package: #'BlocPac-DragAndDrop' with: [
				spec requires: #(#'BlocCore' #'BlocAnimation') ] ].
]
