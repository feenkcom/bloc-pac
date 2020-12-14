Class {
	#name : #BaselineOfBlocPacInfinite,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacInfinite
}

{ #category : #baseline }
BaselineOfBlocPacInfinite >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.119/src' ].
		spec 
			package: #'BlocPac-Infinite' with: [
				spec requires: #('BlocCore' ). ];
			package: #'BlocPac-Infinite-Layouts' with: [
				spec requires: #('BlocCore' #'BlocPac-Infinite' ). ]. ].

]
