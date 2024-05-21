Extension { #name : #WaitfreeQueue }

{ #category : #'*BlocPac-Imager' }
WaitfreeQueue >> itemCount [
	<gtPharoPatch: #Pharo>
	
	"Answer the number of items in the queue including dummies. 
	If queue is currently in the middle of extraction by other process, give a (very) approximate answer.
	
	This method having a non-deterministic results, because of nature of concurrent shared queue. 
	"
	
	| item count |

	item := dummy.

	count := 0.
	[ item := item next. item == dummy ifFalse: [ count := count + 1 ]. item isCircular ] whileFalse.

	count = 0 ifTrue: [
		"if queue is locked by other process, check the tail and give a (very) approximate answer."
		^ tail object == dummy ifTrue: [ 0 ] ifFalse: [ 1]
		].	

	^ count
]

{ #category : #'*BlocPac-Imager' }
WaitfreeQueue >> printOn: aStream [
	<gtPharoPatch: #Pharo>
	
	aStream 
		nextPutAll: self class name;
		nextPutAll: ' with ';
		print: self size;
		nextPutAll: ' from ';
		print: self itemCount;
	 	nextPutAll: ' items' .
]
