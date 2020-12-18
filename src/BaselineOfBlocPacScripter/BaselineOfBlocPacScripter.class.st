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
				self repository: 'github://feenkcom/Bloc/src' for: spec ];
			baseline: 'BlocLayout' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ];

			baseline: 'BlocPacGeometry' with: [
				self thisRepositoryFor: spec ].

		spec 
			package: #'BlocPac-Scripter' with: [
				spec requires: #(#'BlocCore' #'BlocLayout' #'BlocPacGeometry') ] ].
]
