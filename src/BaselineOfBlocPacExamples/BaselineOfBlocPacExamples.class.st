Class {
	#name : #BaselineOfBlocPacExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacExamples
}

{ #category : #baseline }
BaselineOfBlocPacExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'BlocPac' with: [
				spec repository: 'github://feenkcom/bloc-pac:v0.6.666/src' ].
		spec
			baseline: 'BlocExamples' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.735/src' ].

		spec package: 'BlocPac-CommonParent-Examples' with: [
			spec requires: #(#BlocPac) ].
		spec package: 'BlocPac-FocusFinder-Examples' with: [
			spec requires: #(#BlocPac) ].
		spec package: 'BlocPac-Geometry-Examples' with: [
			spec requires: #(#BlocPac) ].
		spec package: 'BlocPac-Imager-Examples' with: [
			spec requires: #(#BlocPac) ].
		spec package: 'BlocPac-Infinite-Examples' with: [
			spec requires: #(#BlocPac) ].
		spec package: 'BlocPac-Overlay-Examples' with: [
			spec requires: #(#BlocPac) ].
		spec package: 'BlocPac-PannableAndZoomable-Examples' with: [
			spec requires: #(#BlocPac) ].
		spec package: 'BlocPac-PullAndSlide-Examples' with: [
			spec requires: #(#BlocPac #BlocExamples) ].
		spec package: 'BlocPac-Scrollable-Examples' with: [
			spec requires: #(#BlocPac) ].
		spec package: 'BlocPac-Demos' with: [
			spec requires: #(#BlocPac) ].
	]
]
