Class {
	#name : #BaselineOfBlocPacImager,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacImager
}

{ #category : #baseline }
BaselineOfBlocPacImager >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocPacTasker' with: [
				spec repository: 'github://feenkcom/bloc-pac:main' ];
			baseline: 'BlocPacAsyncElement' with: [
				spec repository: 'github://feenkcom/bloc-pac:main' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon/repository' ];
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta/src' ].
		spec 
			package: #'BlocPac-Imager' with: [
				spec requires: #(#'BlocCore' #'BlocPacTasker' #'BlocPacAsyncElement' #'Beacon' #'SpartaSkia') ] ]
]
