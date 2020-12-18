Class {
	#name : #BaselineOfBlocPacAsyncElement,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacAsyncElement
}

{ #category : #baseline }
BaselineOfBlocPacAsyncElement >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ];
			baseline: 'BlocPacTasker' with: [
				self thisRepositoryFor: spec ].
		spec 
			package: #'BlocPac-AsyncElement' with: [
				spec requires: #(#'BlocCore' #'BlocPacTasker') ] ].
]
