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
				spec repository: 'github://feenkcom/bloc-pac:main/src' ];
			baseline: 'BlocExamples' with: [
				spec repository: 'github://feenkcom/Bloc:main/src' ].
		spec 
			package: #'BlocPac-AsyncElement-Examples' with: [
				spec requires: #('BlocPac' ). ];
			package: #'BlocPac-CommonParent-Examples' with: [
				spec requires: #('BlocPac' ). ];
			package: #'BlocPac-FocusFinder-Examples' with: [
				spec requires: #('BlocPac' ). ];
			package: #'BlocPac-Geometry-Examples' with: [
				spec requires: #('BlocPac' ). ];
			package: #'BlocPac-Imager-Examples' with: [
				spec requires: #('BlocPac' ). ];
			package: #'BlocPac-Infinite-Examples' with: [
				spec requires: #('BlocPac' ). ];
			package: #'BlocPac-Overlay-Examples' with: [
				spec requires: #('BlocPac' ). ];
			package: #'BlocPac-PannableAndZoomable-Examples' with: [
				spec requires: #('BlocPac' ). ];
			package: #'BlocPac-PullAndSlide-Examples' with: [
				spec requires: #('BlocPac' 'BlocExamples' ). ];
			package: #'BlocPac-Scrollable-Examples' with: [
				spec requires: #('BlocPac' ). ];
			package: #'BlocPac-Demos' with: [
				spec requires: #('BlocPac' ). ]. ].

]
