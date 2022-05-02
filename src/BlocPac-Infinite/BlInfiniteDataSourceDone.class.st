Class {
	#name : #BlInfiniteDataSourceDone,
	#superclass : #BlInfiniteDataSourceEvent,
	#category : #'BlocPac-Infinite-DataSource'
}

{ #category : #accessing }
BlInfiniteDataSourceDone >> sendTo: anObject [
	anObject onDone: self
]
