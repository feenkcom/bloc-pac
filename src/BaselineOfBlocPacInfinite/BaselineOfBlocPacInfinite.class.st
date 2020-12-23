Class {
	#name : #BaselineOfBlocPacInfinite,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacInfinite
}

{ #category : #baseline }
BaselineOfBlocPacInfinite >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocPacScrollable' with: [
				spec repository: 'github://feenkcom/bloc-pac:main/src' ].
		spec 
			package: #'BlocPac-Infinite' with: [
				spec requires: #(#'BlocCore' #'BlocPacScrollable') ];
			package: #'BlocPac-Infinite-Layouts' with: [
				spec requires: #(#'BlocCore' #'BlocPac-Infinite') ] ].
]
