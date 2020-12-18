Class {
	#name : #BaselineOfBlocPacResizable,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacResizable
}

{ #category : #baseline }
BaselineOfBlocPacResizable >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				self repository: 'github://feenkcom/Bloc/src' for: self ];
			baseline: 'BlocPacOverlay' with: [
				self thisRepositoryFor: spec ].
		spec 
			package: #'BlocPac-Resizable' with: [
				spec requires: #(#'BlocCore' #'BlocPacOverlay') ] ]
]
