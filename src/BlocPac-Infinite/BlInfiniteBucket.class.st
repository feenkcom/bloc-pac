"
I am a better implementation of a Bitset that provides methods to offset indices using an underlying integer
"
Class {
	#name : #BlInfiniteBucket,
	#superclass : #Object,
	#instVars : [
		'integer'
	],
	#category : #'BlocPac-Infinite-Utils'
}

{ #category : #initialization }
BlInfiniteBucket >> clear: index [
	integer bitAt: index put: 0
]

{ #category : #accessing }
BlInfiniteBucket >> countOnesBefore: anIndex [
	| mask bitcount bits |
	mask := (1 bitShift: anIndex - 1) - 1.
	bits := integer bitAnd: mask.
	bitcount := 0.
	[ bits isZero ]
		whileFalse:
			[ bitcount := bitcount + (bits bitAnd: 1).
			bits bitShift: -1 ].
	^ bitcount
]

{ #category : #initialization }
BlInfiniteBucket >> get: index [
	^ (integer bitAt: index) = 1
]

{ #category : #initialization }
BlInfiniteBucket >> initialize [
	super initialize.
	
	self reset
]

{ #category : #'spec protocol' }
BlInfiniteBucket >> insert: aBoolean at: index [
	| top bottom mask |
	mask := (1 bitShift: index - 1) - 1.
	bottom := integer bitAnd: mask.
	top := integer bitXor: bottom.
	integer := (top bitShift: 1) + (aBoolean asBit bitShift: index - 1) + bottom
]

{ #category : #removing }
BlInfiniteBucket >> remove: index [
	| top bottom mask result |
	result := (integer bitAt: index) = 1.
	integer := integer bitAt: index put: 0.
	mask := (1 bitShift: index - 1) - 1.
	bottom := integer bitAnd: mask.
	top := integer bitXor: bottom.
	integer := (top bitShift: -1) + bottom.
	^result
]

{ #category : #initialization }
BlInfiniteBucket >> reset [
	integer := 0
]

{ #category : #initialization }
BlInfiniteBucket >> set: index [
	integer := integer bitAt: index put: 1
]
