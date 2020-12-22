Class {
	#name : #BaselineOfBlocPacElementQuery,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacElementQuery
}

{ #category : #baseline }
BaselineOfBlocPacElementQuery >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				self repository: 'github://feenkcom/Bloc/src' for: spec ].
		spec 
			package: #'BlocPac-ElementQuery' with: [
				spec requires: #(#BlocCore) ] ].
]
