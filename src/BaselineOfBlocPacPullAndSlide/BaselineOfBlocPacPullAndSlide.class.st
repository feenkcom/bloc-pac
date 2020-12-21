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
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc/src' ].
		spec 
			package: #'BlocPac-PullAndSlide' with: [
				spec requires: #(#'Bloc') ] ]
]
