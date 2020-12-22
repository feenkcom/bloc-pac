Class {
	#name : #BaselineOfBlocPacPannableAndZoomable,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacPannableAndZoomable
}

{ #category : #baseline }
BaselineOfBlocPacPannableAndZoomable >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ];
			baseline: 'BlocPacPullAndSlide' with: [
				self thisRepositoryFor: spec ].
		spec 
			package: #'BlocPac-PannableAndZoomable' with: [
				spec requires: #(#'BlocCore' #'BlocPacPullAndSlide') ] ].
]
