Extension { #name : #BlDirectEventDispatcher }

{ #category : #'*BlocPac-ElementQuery' }
BlDirectEventDispatcher >> forwardShortcuts [
	"Forward shortcuts to another element. 
	See BlShortcutForwardingHandler class comment for more details."

	<return: #BlShortcutForwardingHandler>
	shortcutHandler := shortcutHandler forwardShortcuts.
	^ shortcutHandler
]

{ #category : #'*BlocPac-ElementQuery' }
BlDirectEventDispatcher >> noForwardShortcuts [
	"Disable forwarding shortcuts to another element.
	See BlShortcutForwardingHandler class comment for more details."

	<return: #BlShortcutHandler>
	shortcutHandler := shortcutHandler noForwardShortcuts.
	^ shortcutHandler
]
