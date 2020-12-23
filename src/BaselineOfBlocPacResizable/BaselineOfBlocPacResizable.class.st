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
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocPacOverlay' with: [
				spec repository: 'github://feenkcom/bloc-pac:main/src' ].
		spec 
			package: #'BlocPac-Resizable' with: [
				spec requires: #(#'BlocCore' #'BlocPacOverlay') ] ]
]
