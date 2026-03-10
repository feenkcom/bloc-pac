Extension { #name : #BlShortcutHandler }

{ #category : #'*BlocPac-ElementQuery' }
BlShortcutHandler >> forwardShortcuts [
	"Forward shortcuts to another element"

	<return: #BlShortcutForwardingHandler>
	^ BlShortcutForwardingHandler new shortcutHandler: self
]

{ #category : #'*BlocPac-ElementQuery' }
BlShortcutHandler >> noForwardShortcuts [
	"Do not forward shortcuts to another element"

	<return: #BlShortcutHandler>
	^ self
]
