Class {
	#name : #BaselineOfBlocPacScalable,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacScalable
}

{ #category : #baseline }
BaselineOfBlocPacScalable >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ].
		spec 
			package: #'BlocPac-Scalable' with: [
				spec requires: #(#BlocCore) ] ].
]
