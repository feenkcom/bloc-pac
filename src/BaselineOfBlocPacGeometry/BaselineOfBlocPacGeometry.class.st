Class {
	#name : #BaselineOfBlocPacGeometry,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacGeometry
}

{ #category : #baseline }
BaselineOfBlocPacGeometry >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ];
			baseline: 'BlocLayout' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ];
			
			baseline: 'BlocPacPullAndSlide' with: [
				self thisRepositoryFor: spec ].

		spec 
			package: #'BlocPac-Geometry' with: [
				spec requires: #(#'BlocCore' #'BlocLayout' #'BlocPacPullAndSlide') ] ].
]
