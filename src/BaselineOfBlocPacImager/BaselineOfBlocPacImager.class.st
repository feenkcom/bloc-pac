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
				self repository: 'github://feenkcom/Bloc/src' for: self ];
			baseline: 'BlocPacTasker' with: [
				self thisRepositoryFor: spec ];
			baseline: 'BlocPacAsyncElement' with: [
				self thisRepositoryFor: spec ];
			baseline: 'Beacon' with: [
				self repository: 'github://feenkcom/pharo-beacon/repository' for: self ];
			baseline: 'SpartaSkia' with: [
				self repository: 'github://feenkcom/Sparta/src' for: self ].
		spec 
			package: #'BlocPac-Imager' with: [
				spec requires: #(#'BlocCore' #'BlocPacTasker' #'BlocPacAsyncElement' #'Beacon' #'SpartaSkia') ] ]
]
