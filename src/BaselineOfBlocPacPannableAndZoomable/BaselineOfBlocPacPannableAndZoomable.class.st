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
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocPacPullAndSlide' with: [
				spec repository: 'github://feenkcom/bloc-pac:main/src' ].
		spec 
			package: #'BlocPac-PannableAndZoomable' with: [
				spec requires: #(#'BlocCore' #'BlocPacPullAndSlide') ] ].
]
