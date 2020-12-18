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
				self repository: 'github://feenkcom/Bloc/src' for: self ].
		spec 
			package: #'BlocPac-Overlay' with: [
				spec requires: #(#'BlocCore') ] ]
]
