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
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'Beacon' with: [
				spec repository: 'github://feenkcom/pharo-beacon/repository' ];
			baseline: 'SpartaSkia' with: [
				spec repository: 'github://feenkcom/Sparta/src' ];
			baseline: 'TaskIt' with: [
				spec repository: 'github://feenkcom/taskit:feenk102' ].

		spec 
			package: #'BlocPac-AsyncElement' with: [
				spec requires: #(#'Bloc' #'BlocPac-Tasker') ];
			package: #'BlocPac-AsyncElement-Examples' with: [
				spec requires: #(#'Beacon' #'Bloc' #'BlocPac-AsyncElement'  #'BlocPac-Tasker') ];
			package: #'BlocPac-DragAndDrop' with: [
				spec requires: #(#'Bloc') ];
			package: #'BlocPac-ElementQuery' with: [
				spec requires: #(#'Bloc') ];
			package: #'BlocPac-FocusFinder' with: [
				spec requires: #(#'Bloc') ];
			
			package: #'BlocPac-Geometry' with: [
				spec requires: #(#'Bloc' #'BlocPac-PullAndSlide') ];
			package: #'BlocPac-Imager' with: [
				spec requires: #(#'Bloc' #'Beacon' #'SpartaSkia' #'BlocPac-AsyncElement' #'BlocPac-Tasker') ];
			package: #'BlocPac-Infinite' with: [
				spec requires: #(#'Bloc' #'BlocPac-Scrollable') ];
			package: #'BlocPac-Infinite-Layouts' with: [
				spec requires: #(#'Bloc' #'BlocPac-Infinite') ];
			
			package: #'BlocPac-Overlay' with: [
				spec requires: #(#'Bloc') ];
			package: #'BlocPac-PannableAndZoomable' with: [
				spec requires: #(#'Bloc' #'BlocPac-PullAndSlide') ];
			package: #'BlocPac-PullAndSlide' with: [
				spec requires: #(#'Bloc') ];
			
			package: #'BlocPac-Resizable' with: [
				spec requires: #(#'Bloc' 'BlocPac-Overlay') ];
			package: #'BlocPac-Scalable' with: [
				spec requires: #(#'Bloc') ];
			package: #'BlocPac-Scripter' with: [
				spec requires: #(#'Bloc' 'BlocPac-Geometry') ];
			
			package: #'BlocPac-Scrollable' with: [
				spec requires: #(#'Bloc' #'BlocPac-PullAndSlide') ];
			package: #'BlocPac-Tasker' with: [
				spec requires: #(#'Bloc' #'TaskIt') ];
			
			package: #'BlocPac-Infinite' with: [
				spec requires: #(#'Bloc') ] ].
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
