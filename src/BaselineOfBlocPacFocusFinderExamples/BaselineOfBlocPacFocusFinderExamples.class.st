Class {
	#name : #BaselineOfBlocPacFocusFinderExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacFocusFinderExamples
}

{ #category : #baseline }
BaselineOfBlocPacFocusFinderExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocLayouts' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocPacFocusFinder' with: [
				spec repository: 'github://feenkcom/bloc-pac:main/src' ].
		spec 
			package: #'BlocPac-FocusFinder-Examples' with: [
				spec requires: #(#BlocPacFocusFinder #BlocCore #BlocLayouts) ] ]
]
