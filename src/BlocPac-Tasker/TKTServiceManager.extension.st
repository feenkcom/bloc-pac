Extension { #name : 'TKTServiceManager' }

{ #category : '*BlocPac-Tasker' }
TKTServiceManager >> poolWorkerNamed: aString [
	<return: #TKTCommonQueueWorkerPool or: nil>
	^ self services 
		detect: [ :any | any hasPoolWorkerNamed: aString ]
		ifFound: [ :aService | aService pool ]
		ifNone: [ nil ]
]
