Class {
	#name : #BlTaskAtNotScheduledShiftingExecutionHandler,
	#superclass : #BlTaskAtNotScheduledHandler,
	#category : 'BlocPac-Tasker-Postponed Tasks'
}

{ #category : #handling }
BlTaskAtNotScheduledShiftingExecutionHandler >> notScheduled: aNotScheduleTask becauseOf: aScheduledTask [
	"aBlTaskAtTask will be executed at the time of the ignored task"
	aScheduledTask scheduledTime: aNotScheduleTask scheduledTime
]
