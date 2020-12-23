Class {
	#name : #BaselineOfBlocPacTasker,
	#superclass : #BaselineOf,
	#classVars : [
		'PostLoaded'
	],
	#category : #BaselineOfBlocPacTasker
}

{ #category : #baseline }
BaselineOfBlocPacTasker >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec postLoadDoIt: #'postLoadTasker:'.

		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'TaskIt' with: [
				spec repository: 'github://feenkcom/taskit:feenk102' ].
		spec 
			package: #'BlocPac-Tasker' with: [
				spec requires: #(#'BlocCore' #'TaskIt') ] ].
]

{ #category : #'post load' }
BaselineOfBlocPacTasker >> postLoadDisableTaskItDebugger: spec [
	(self class environment at: #TKTConfiguration) profileNamed: #gtTest.
	(self class environment at: #TKTDebugger) disable.
]

{ #category : #'post load' }
BaselineOfBlocPacTasker >> postLoadTasker: spec [
	(PostLoaded isNotNil and: [ PostLoaded ])
		ifTrue: [ ^ self ].
		
	PostLoaded := true.
	self postLoadDisableTaskItDebugger: spec
]
