Class {
	#name : #BlTktProcess,
	#superclass : #TKTProcess,
	#category : 'BlocPac-Tasker-Processes'
}

{ #category : #private }
BlTktProcess >> privateCreatePharoProcess [
	"Return an instance of TKTConfiguration process which is usually Process."
	<return: #Process>
	process := BlTaskProcess
		forContext: self createContext
		priority: self spawnPriority.
	process name: self name.
	process task: self task.
	^ process
]

{ #category : #private }
BlTktProcess >> task [
	^ self annotation: #task
]
