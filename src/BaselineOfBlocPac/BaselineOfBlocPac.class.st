Class {
	#name : #BaselineOfBlocPac,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPac
}

{ #category : #baseline }
BaselineOfBlocPac >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:main/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon/repository' ];
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:main/src' ].
		spec 
			package: #'BlocPac-CommonParent' with: [
				spec requires: #('Bloc' ). ];
			package: #'BlocPac-DragAndDrop' with: [
				spec requires: #('Bloc' ). ];
			package: #'BlocPac-ElementQuery' with: [
				spec requires: #('Bloc' ). ];
			package: #'BlocPac-ErrorHandling' with: [
				spec requires: #('Bloc' ). ];
			package: #'BlocPac-FocusFinder' with: [
				spec requires: #('Bloc' ). ];
			package: #'BlocPac-Overlay' with: [
				spec requires: #('Bloc' ). ];
			package: #'BlocPac-PullAndSlide' with: [
				spec requires: #('Bloc' ). ];
			package: #'BlocPac-PannableAndZoomable' with: [
				spec requires: #('Bloc' #'BlocPac-PullAndSlide' ). ];
			package: #'BlocPac-Geometry' with: [
				spec requires: #('Bloc' #'BlocPac-PullAndSlide' #'BlocPac-CommonParent'). ];
			package: #'BlocPac-Resizable' with: [
				spec requires: #('Bloc' #'BlocPac-Overlay' ). ];
			package: #'BlocPac-Scalable' with: [
				spec requires: #('Bloc' ). ];
			package: #'BlocPac-Scrollable' with: [
				spec requires: #('Bloc' #'BlocPac-PullAndSlide' ). ];
			package: #'BlocPac-Infinite' with: [
				spec requires: #('Bloc' #'BlocPac-Scrollable' 'Bloc' ). ];
			package: #'BlocPac-Infinite-Layouts' with: [
				spec requires: #('Bloc' #'BlocPac-Infinite' ). ];
			package: #'BlocPac-Imager' with: [
				spec requires: #('Bloc' 'Beacon' 'SpartaSkia'). ]. ].

]
