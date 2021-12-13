Extension { #name : #TBlDevScripterTarget }

{ #category : #'*BlocPac-ElementQuery' }
TBlDevScripterTarget >> / aBlElementQueryByPropertySelector [
	"Selects among direct children based on a given selector such as id or class"
	<scripterStepTarget>

	self updateTarget: (BlDevScripterOneElementQueryEventTarget new / aBlElementQueryByPropertySelector)
]

{ #category : #'*BlocPac-ElementQuery' }
TBlDevScripterTarget >> // aBlElementQueryByPropertySelector [
	"Selects among all children (depth first) based on a given selector such as id or class"
	<scripterStepTarget>

	self updateTarget: (BlDevScripterOneElementQueryEventTarget new // aBlElementQueryByPropertySelector)
]

{ #category : #'*BlocPac-ElementQuery' }
TBlDevScripterTarget >> @ aBlElementQueryByPredicate [
	"Filters the result of the previous selection based on a predicate (such as index)"
	<scripterStepTarget>

	self updateTarget: (BlDevScripterOneElementQueryEventTarget new @ aBlElementQueryByPredicate)
]
