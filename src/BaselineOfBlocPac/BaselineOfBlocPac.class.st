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
				spec repository: 'github://feenkcom/Bloc:v0.9.61/src' ].
		spec
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:14f253625b0e28a538c28182025440036991b339/repository' ].
		spec
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.240/src' ].
		spec
			baseline: 'XMLParserForGlamorousToolkit' with: [
				spec repository: 'github://feenkcom/XML-XMLParser:v0.6.4/src' ].

		spec package: 'BlocPac-CommonParent' with: [
			spec requires: #(#Bloc) ].
		spec package: 'BlocPac-DragAndDrop' with: [
			spec requires: #(#Bloc) ].
		spec package: 'BlocPac-ElementQuery' with: [
			spec requires: #(#Bloc) ].
		spec package: 'BlocPac-ErrorHandling' with: [
			spec requires: #(#Bloc) ].
		spec package: 'BlocPac-FocusFinder' with: [
			spec requires: #(#Bloc) ].
		spec package: 'BlocPac-Overlay' with: [
			spec requires: #(#Bloc) ].
		spec package: 'BlocPac-PullAndSlide' with: [
			spec requires: #(#Bloc) ].
		spec package: 'BlocPac-PannableAndZoomable' with: [
			spec requires: #(#Bloc #'BlocPac-PullAndSlide') ].
		spec package: 'BlocPac-Geometry' with: [
			spec requires: #(#Bloc #'BlocPac-PullAndSlide' #'BlocPac-CommonParent' #XMLParserForGlamorousToolkit) ].
		spec package: 'BlocPac-Resizable' with: [
			spec requires: #(#Bloc #'BlocPac-Overlay') ].
		spec package: 'BlocPac-Scalable' with: [
			spec requires: #(#Bloc) ].
		spec package: 'BlocPac-Scrollable' with: [
			spec requires: #(#Bloc #'BlocPac-PullAndSlide') ].
		spec package: 'BlocPac-Infinite' with: [
			spec requires: #(#Bloc #'BlocPac-Scrollable' #Bloc) ].
		spec package: 'BlocPac-Infinite-Layouts' with: [
			spec requires: #(#Bloc #'BlocPac-Infinite') ].
		spec package: 'BlocPac-Imager' with: [
			spec requires: #(#Bloc #Beacon #SpartaSkia) ].
		spec package: 'BlocPac-Examples' with: [
			spec requires: #(#'BlocPac-ElementQuery') ].
	]
]
