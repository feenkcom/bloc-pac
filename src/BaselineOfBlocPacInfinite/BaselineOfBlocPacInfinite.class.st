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
				self repository: 'github://feenkcom/Bloc/src' for: spec ];
			baseline: 'BlocPacScrollable' with: [
				self thisRepositoryFor: spec ].
		spec 
			package: #'BlocPac-Infinite' with: [
				spec requires: #(#'BlocCore' #'BlocPacScrollable') ];
			package: #'BlocPac-Infinite-Layouts' with: [
				spec requires: #(#'BlocCore' #'BlocPac-Infinite') ] ].
]
