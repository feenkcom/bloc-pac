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
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocLayout' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			
			baseline: 'BlocPac-PullAndSlide' with: [
				spec repository: 'github://feenkcom/bloc-pac:main/src' ].

		spec 
			package: #'BlocPac-Geometry' with: [
				spec requires: #(#'BlocCore' #'BlocLayout' #'BlocPac-PullAndSlide') ] ].
]
