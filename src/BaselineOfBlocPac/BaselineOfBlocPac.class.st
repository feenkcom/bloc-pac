Class {
	#name : #BaselineOfBlocPac,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfBlocPac
}

{ #category : #baseline }
BaselineOfBlocPac >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec postLoadDoIt: #'postLoadTasker:'.
		spec 
			baseline: 'Bloc' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.221/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon:a119e739bc378ca2a95883e074090d90fed4edeb/repository' ];
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta:v0.8.59/src' ];
			baseline: 'TaskIt' with: [
				spec repository: 'github://feenkcom/taskit:be8fa748709d46db980441af0f9946f3ac89ae33' ].
		spec 
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
				spec requires: #('Bloc' #'BlocPac-PullAndSlide' ). ];
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
			package: #'BlocPac-Tasker' with: [
				spec requires: #('Bloc' 'TaskIt' ). ];
			package: #'BlocPac-AsyncElement' with: [
				spec requires: #('Bloc' #'BlocPac-Tasker' #'BlocPac-ErrorHandling' ). ];
			package: #'BlocPac-Imager' with: [
				spec requires: #('Bloc' 'Beacon' 'SpartaSkia' #'BlocPac-AsyncElement' #'BlocPac-Tasker' ). ]. ].

]

{ #category : #'post load' }
BaselineOfBlocPac >> postLoadDisableTaskItDebugger: spec [
	(self class environment at: #TKTConfiguration) profileNamed: #gtTest.
	(self class environment at: #TKTDebugger) disable.
]

{ #category : #'post load' }
BaselineOfBlocPac >> postLoadTasker: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].
		
	PostLoaded := true.
	self postLoadDisableTaskItDebugger: spec
]
