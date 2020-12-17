Class {
	#name : #BlDevScripterKeyboardStep,
	#superclass : #BlDevScripterStep,
	#instVars : [
		'key'
	],
	#category : #'BlocPac-Scripter-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterKeyboardStep >> key [
	<return: #BlKeyboardKey>

	^ key
]

{ #category : #accessing }
BlDevScripterKeyboardStep >> key: aBlKeyboardKey [
	key := aBlKeyboardKey
]
