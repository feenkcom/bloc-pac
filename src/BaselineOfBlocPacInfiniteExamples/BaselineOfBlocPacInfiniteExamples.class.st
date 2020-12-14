Class {
	#name : #BaselineOfBlocPacInfiniteExamples,
	#superclass : #BaselineOf,
	#category : #BaselineOfBlocPacInfiniteExamples
}

{ #category : #baseline }
BaselineOfBlocPacInfiniteExamples >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'BlocCore' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocLayouts' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocText' with: [
				spec repository: 'github://feenkcom/Bloc/src' ];
			baseline: 'BlocPacInfinite' with: [
				spec repository: 'github://feenkcom/bloc-pac:main/src' ].
		spec 
			package: #'BlocPac-Infinite-Examples' with: [
				spec requires: #('BlocPacInfinite' 'BlocCore' 'BlocLayouts' 'BlocText') ] ]
]
