Class {
	#name : #BaselineOfBlocPacElementQuery,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacElementQuery
}

{ #category : #baseline }
BaselineOfBlocPacElementQuery >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc:v0.8.120/src' ].
		spec package: #'BlocPac-ElementQuery' with: [
				spec requires: #('BlocCore' ). ]. ].

]
