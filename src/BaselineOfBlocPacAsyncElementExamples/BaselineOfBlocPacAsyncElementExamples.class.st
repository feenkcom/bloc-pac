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
				spec repository: 'github://feenkcom/pharo-beacon/repository' ];

			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocLayout' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];

			baseline: 'BlocPacAsyncElement' with: [
				spec repository: 'github://feenkcom/bloc-pac:main' ];
			baseline: 'BlocPacTasker' with: [
				spec repository: 'github://feenkcom/bloc-pac:main' ].
		spec 
			package: #'BlocPac-AsyncElement-Examples' with: [
				spec requires: #(
					#'Beacon'
					
					#'BlocCore'
					#'BlocLayout'

					#'BlocPacAsyncElement'
					#'BlocPacTasker') ] ].
]
