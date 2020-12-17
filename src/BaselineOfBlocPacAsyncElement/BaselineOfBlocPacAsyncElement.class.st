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
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocPacTasker' with: [
				spec repository: 'github://feenkcom/bloc-pac:main' ].
		spec 
			package: #'BlocPac-AsyncElement' with: [
				spec requires: #(#'BlocCore' #'BlocPacTasker') ] ].
]
