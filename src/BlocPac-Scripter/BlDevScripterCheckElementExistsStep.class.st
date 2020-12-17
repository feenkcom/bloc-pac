Class {
	#name : #BlDevScripterCheckElementExistsStep,
	#superclass : #BlDevScripterCheckStep,
	#category : #'BlocPac-Scripter-Scripter-Steps'
}

{ #category : #actions }
BlDevScripterCheckElementExistsStep >> playOn: aScripter [
	| anElement |

	anElement := [ self target findTargetStartingInScripter: aScripter] on: Error do: [ nil ].
	self 
		assert: [ anElement notNil ]
		description: [ 'Element should exist' ].
]
