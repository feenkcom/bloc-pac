Class {
	#name : #BaselineOfBlocPacOverlay,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacOverlay
}

{ #category : #baseline }
BaselineOfBlocPacOverlay >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ].
		spec 
			package: #'BlocPac-Overlay' with: [
				spec requires: #(#'BlocCore') ] ]
]
