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
				spec repository: 'github://feenkcom/Bloc/src' ].
		spec 
			package: #'BlocPac-FocusFinder' with: [
				spec requires: #(#BlocCore) ] ].
]
