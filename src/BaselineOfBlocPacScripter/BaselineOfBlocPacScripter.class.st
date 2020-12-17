Class {
	#name : #BaselineOfBlocPacScripter,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacScripter
}

{ #category : #baseline }
BaselineOfBlocPacScripter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocLayout' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			
			baseline: 'BlocPacGeometry' with: [
				spec repository: 'github://feenkcom/bloc-pac:main/src' ].

		spec 
			package: #'BlocPac-Scripter' with: [
				spec requires: #(#'BlocCore' #'BlocLayout' #'BlocPacGeometry') ] ].
]
