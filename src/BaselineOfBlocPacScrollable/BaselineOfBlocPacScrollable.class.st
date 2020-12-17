Class {
	#name : #BaselineOfBlocPacScrollable,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacScrollable
}

{ #category : #baseline }
BaselineOfBlocPacScrollable >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocLayout' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocPacPullAndSlide' with: [
				spec repository: 'github://feenkcom/bloc-pac:main' ].
		spec 
			package: #'BlocPac-Scrollable' with: [
				spec requires: #(#'BlocCore' #'BlocLayout' #'BlocPacPullAndSlide') ] ].
]
