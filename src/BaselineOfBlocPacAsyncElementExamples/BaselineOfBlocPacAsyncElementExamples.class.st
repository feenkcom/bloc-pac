Class {
	#name : #BaselineOfBlocPacAsyncElementExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacAsyncElementExamples
}

{ #category : #baseline }
BaselineOfBlocPacAsyncElementExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Beacon' with: [
				self repository: 'github://feenkcom/pharo-beacon/repository' for: spec ];

			baseline: 'BlocCore' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ];
			baseline: 'BlocLayout' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ];

			baseline: 'BlocPacAsyncElement' with: [
				self thisRepositoryFor: spec ];
			baseline: 'BlocPacTasker' with: [
				self thisRepositoryFor: spec ].
		spec 
			package: #'BlocPac-AsyncElement-Examples' with: [
				spec requires: #(
					#'Beacon'
					
					#'BlocCore'
					#'BlocLayout'

					#'BlocPacAsyncElement'
					#'BlocPacTasker') ] ].
]
