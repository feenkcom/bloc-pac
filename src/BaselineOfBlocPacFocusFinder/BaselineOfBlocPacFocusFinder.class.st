Class {
	#name : #BaselineOfBlocPacFocusFinder,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacFocusFinder
}

{ #category : #baseline }
BaselineOfBlocPacFocusFinder >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ].
		spec 
			package: #'BlocPac-FocusFinder' with: [
				spec requires: #(#BlocCore) ] ].
]
