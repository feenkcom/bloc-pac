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
				self repository: 'github://feenkcom/Bloc/src' for: self ].
		spec 
			package: #'BlocPac-Scalable' with: [
				spec requires: #(#BlocCore) ] ].
]
