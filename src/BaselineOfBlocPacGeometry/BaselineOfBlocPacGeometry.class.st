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
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			
			baseline: 'BlocPacPullAndSlide' with: [
				spec repository: 'github://feenkcom/bloc-pac:main/src' ].

		spec 
			package: #'BlocPac-Geometry' with: [
				spec requires: #(#'Bloc' #'BlocPacPullAndSlide') ] ].
]
