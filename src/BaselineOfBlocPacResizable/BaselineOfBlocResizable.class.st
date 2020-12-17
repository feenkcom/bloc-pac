Class {
	#name : #BaselineOfBlocResizable,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacResizable
}

{ #category : #baseline }
BaselineOfBlocResizable >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocPacOverlay' with: [
				spec repository: 'github://feenkcom/bloc-pac:main' ].
		spec 
			package: #'BlocPac-Resizable' with: [
				spec requires: #(#'BlocCore' #'BlocPacOverlay') ] ]
]
