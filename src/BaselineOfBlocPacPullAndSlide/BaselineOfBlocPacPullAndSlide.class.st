Class {
	#name : #BaselineOfBlocPacPullAndSlide,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacPullAndSlide
}

{ #category : #baseline }
BaselineOfBlocPacPullAndSlide >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ].
		spec 
			package: #'BlocPac-PullAndSlide' with: [
				spec requires: #(#'BlocCore') ] ]
]
