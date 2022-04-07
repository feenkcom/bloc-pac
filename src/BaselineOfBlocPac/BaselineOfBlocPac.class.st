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
				spec repository: 'github://feenkcom/Bloc:v0.8.323/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:837990633c65a3193432df1684bcb54cc9f070c6/repository' ].
		spec
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.91/src' ].

		spec package: 'BlocPac-CommonParent' with: [
			spec requires: #('Bloc') ].
		spec package: 'BlocPac-DragAndDrop' with: [
			spec requires: #('Bloc') ].
		spec package: 'BlocPac-ElementQuery' with: [
			spec requires: #('Bloc') ].
		spec package: 'BlocPac-ErrorHandling' with: [
			spec requires: #('Bloc') ].
		spec package: 'BlocPac-FocusFinder' with: [
			spec requires: #('Bloc') ].
		spec package: 'BlocPac-Overlay' with: [
			spec requires: #('Bloc') ].
		spec package: 'BlocPac-PullAndSlide' with: [
			spec requires: #('Bloc') ].
		spec package: 'BlocPac-PannableAndZoomable' with: [
			spec requires: #('Bloc' #'BlocPac-PullAndSlide') ].
		spec package: 'BlocPac-Geometry' with: [
			spec requires: #('Bloc' #'BlocPac-PullAndSlide' #'BlocPac-CommonParent') ].
		spec package: 'BlocPac-Resizable' with: [
			spec requires: #('Bloc' #'BlocPac-Overlay') ].
		spec package: 'BlocPac-Scalable' with: [
			spec requires: #('Bloc') ].
		spec package: 'BlocPac-Scrollable' with: [
			spec requires: #('Bloc' #'BlocPac-PullAndSlide') ].
		spec package: 'BlocPac-Infinite' with: [
			spec requires: #('Bloc' #'BlocPac-Scrollable' 'Bloc') ].
		spec package: 'BlocPac-Infinite-Layouts' with: [
			spec requires: #('Bloc' #'BlocPac-Infinite') ].
		spec package: 'BlocPac-Imager' with: [
			spec requires: #('Bloc' 'Beacon' 'SpartaSkia') ].
	]
]
